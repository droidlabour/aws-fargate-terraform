data "template_file" "container_def" {
  template = "${file("resources/container_def.json")}"
  vars = {
    name  = var.taskdef_name
    image = var.ecr_image
  }
}


resource "aws_ecs_task_definition" "service" {
  cpu                      = "256"
  family                   = var.taskdef_name
  memory                   = "512"
  depends_on               = ["aws_iam_role.ecs_task_execution_role"]
  network_mode             = "awsvpc"
  task_role_arn            = "${aws_iam_role.ecs_task_execution_role.arn}"
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
  container_definitions    = "${data.template_file.container_def.rendered}"
  requires_compatibilities = ["FARGATE"]
}


# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.taskdef_name}-ecs-exec-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}


data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = "${aws_iam_role.ecs_task_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "app_role" {
  name               = "${var.taskdef_name}-ecs-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.app_role_assume_role_policy.json}"
}


data "aws_iam_policy_document" "app_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


resource "aws_iam_role_policy" "app_policy" {
  name   = "${var.taskdef_name}-ecs-iam-policy"
  role   = "${aws_iam_role.app_role.id}"
  policy = "${data.aws_iam_policy_document.app_policy.json}"
}


data "aws_iam_policy_document" "app_policy" {
  statement {
    actions = [
      "ecs:DescribeClusters",
    ]
    resources = ["*"]
  }
}
