###########################
# ECS Task Execution Role #
###########################
resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.name}-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume.json
}

data "aws_iam_policy_document" "ecs_task_execution_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

###########################
# ECS Task Role (App)     #
###########################
resource "aws_iam_role" "ecs_task" {
  name = "${var.name}-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# Inline policy to allow Secrets Manager + EFS
resource "aws_iam_role_policy" "ecs_task_inline" {
  name = "${var.name}-task-inline"
  role = aws_iam_role.ecs_task.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["secretsmanager:GetSecretValue"],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = ["elasticfilesystem:*"],
        Resource = "*"
      }
    ]
  })
}

###########################
# ECS Exec (SSM)          #
###########################
resource "aws_iam_role_policy_attachment" "ecs_task_ssm" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

###########################
# CodeDeploy Role         #
###########################
resource "aws_iam_role" "codedeploy" {
  name = "${var.name}-codedeploy-role"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume.json
}

data "aws_iam_policy_document" "codedeploy_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
  role       = aws_iam_role.codedeploy.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForECS"
}
