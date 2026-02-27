pub const SavingsPlanType = enum {
    compute,
    ec2_instance,
    sagemaker,
    database,

    pub const json_field_names = .{
        .compute = "COMPUTE",
        .ec2_instance = "EC2_INSTANCE",
        .sagemaker = "SAGEMAKER",
        .database = "DATABASE",
    };
};
