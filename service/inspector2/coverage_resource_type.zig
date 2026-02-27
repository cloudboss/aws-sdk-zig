pub const CoverageResourceType = enum {
    aws_ec2_instance,
    aws_ecr_container_image,
    aws_ecr_repository,
    aws_lambda_function,
    code_repository,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_ecr_container_image = "AWS_ECR_CONTAINER_IMAGE",
        .aws_ecr_repository = "AWS_ECR_REPOSITORY",
        .aws_lambda_function = "AWS_LAMBDA_FUNCTION",
        .code_repository = "CODE_REPOSITORY",
    };
};
