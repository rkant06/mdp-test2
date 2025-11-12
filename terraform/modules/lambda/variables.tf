variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_function_path" {
  description = "Path to the Lambda function code"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket the Lambda can access"
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to prebuilt lambda zip file"
  type        = string
  default     = ""
}