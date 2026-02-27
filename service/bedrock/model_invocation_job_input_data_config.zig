const ModelInvocationJobS3InputDataConfig = @import("model_invocation_job_s3_input_data_config.zig").ModelInvocationJobS3InputDataConfig;

/// Details about the location of the input to the batch inference job.
pub const ModelInvocationJobInputDataConfig = union(enum) {
    /// Contains the configuration of the S3 location of the input data.
    s_3_input_data_config: ?ModelInvocationJobS3InputDataConfig,

    pub const json_field_names = .{
        .s_3_input_data_config = "s3InputDataConfig",
    };
};
