module "mdp-image_resize_service" {
    source = "../../modules/s3"
    bucket_name = "mdp-image_resize_service"
    environment = var.environment
}

resource "aws_s3_object" "image_landing_zone" {
    bucket = module.mdp-image_resize_service.bucket_name
    key = "landing-zone/"
    content = ""
}

resource "aws_s3_object" "image_output_zone" {
    bucket = module.mdp-image_resize_service.bucket_name
    key = "output-zone/"
    content = ""
}

module "mdp-image_resize_service_lambda" {
    source  = "../../modules/lambda"

    function_name        = "mdp-image_resize_service"
    lambda_function_path = "../src/image_resize_service"
    environment          = var.environment
    s3_bucket_arn        = module.mdp-image_resize_service.bucket_arn
    lambda_zip_path      = "../../../src/image_resize_service/lambda_function.zip"
}
