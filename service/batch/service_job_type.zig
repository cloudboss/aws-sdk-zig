pub const ServiceJobType = enum {
    sagemaker_training,

    pub const json_field_names = .{
        .sagemaker_training = "SAGEMAKER_TRAINING",
    };
};
