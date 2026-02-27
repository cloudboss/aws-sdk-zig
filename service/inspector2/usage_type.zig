pub const UsageType = enum {
    ec2_instance_hours,
    ecr_initial_scan,
    ecr_rescan,
    lambda_function_hours,
    lambda_function_code_hours,
    code_repository_sast,
    code_repository_iac,
    code_repository_sca,
    ec2_agentless_instance_hours,

    pub const json_field_names = .{
        .ec2_instance_hours = "EC2_INSTANCE_HOURS",
        .ecr_initial_scan = "ECR_INITIAL_SCAN",
        .ecr_rescan = "ECR_RESCAN",
        .lambda_function_hours = "LAMBDA_FUNCTION_HOURS",
        .lambda_function_code_hours = "LAMBDA_FUNCTION_CODE_HOURS",
        .code_repository_sast = "CODE_REPOSITORY_SAST",
        .code_repository_iac = "CODE_REPOSITORY_IAC",
        .code_repository_sca = "CODE_REPOSITORY_SCA",
        .ec2_agentless_instance_hours = "EC2_AGENTLESS_INSTANCE_HOURS",
    };
};
