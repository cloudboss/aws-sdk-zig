pub const AggregationType = enum {
    finding_type,
    package,
    title,
    repository,
    ami,
    aws_ec2_instance,
    aws_ecr_container,
    image_layer,
    account,
    aws_lambda_function,
    lambda_layer,
    code_repository,

    pub const json_field_names = .{
        .finding_type = "FINDING_TYPE",
        .package = "PACKAGE",
        .title = "TITLE",
        .repository = "REPOSITORY",
        .ami = "AMI",
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_ecr_container = "AWS_ECR_CONTAINER",
        .image_layer = "IMAGE_LAYER",
        .account = "ACCOUNT",
        .aws_lambda_function = "AWS_LAMBDA_FUNCTION",
        .lambda_layer = "LAMBDA_LAYER",
        .code_repository = "CODE_REPOSITORY",
    };
};
