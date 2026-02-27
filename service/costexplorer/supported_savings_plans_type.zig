pub const SupportedSavingsPlansType = enum {
    compute_sp,
    ec2_instance_sp,
    sagemaker_sp,
    database_sp,

    pub const json_field_names = .{
        .compute_sp = "COMPUTE_SP",
        .ec2_instance_sp = "EC2_INSTANCE_SP",
        .sagemaker_sp = "SAGEMAKER_SP",
        .database_sp = "DATABASE_SP",
    };
};
