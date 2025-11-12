# IAM Role for Lambda
resource "aws_iam_role" "lambda" {
  name = "${var.function_name}-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach basic Lambda execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# S3 access policy
resource "aws_iam_role_policy" "s3_access" {
  name = "${var.function_name}-s3-access"
  role = aws_iam_role.lambda.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

# # Create deployment package placeholder
# data "archive_file" "lambda_zip" {
#   type        = "zip"
#   output_path = "${path.module}/lambda_function.zip"
  
#   source {
#     content  = file("${path.module}/placeholder.py")
#     filename = "lambda_function.py"
#   }
# }

# Lambda Function
resource "aws_lambda_function" "this" {
  filename         = var.lambda_zip_path 
  function_name    = var.function_name
  role            = aws_iam_role.lambda.arn
  handler         = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256(var.lambda_zip_path)
  runtime         = "python3.11"
  timeout         = 300
  memory_size     = 512
  
  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7
}