pub const ResourceScanType = enum {
    ec2,
    ecr,
    lambda,
    lambda_code,
    code_repository,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .ecr = "ECR",
        .lambda = "LAMBDA",
        .lambda_code = "LAMBDA_CODE",
        .code_repository = "CODE_REPOSITORY",
    };
};
