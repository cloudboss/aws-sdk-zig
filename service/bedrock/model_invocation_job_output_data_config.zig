const ModelInvocationJobS3OutputDataConfig = @import("model_invocation_job_s3_output_data_config.zig").ModelInvocationJobS3OutputDataConfig;

/// Contains the configuration of the S3 location of the output data.
pub const ModelInvocationJobOutputDataConfig = union(enum) {
    /// Contains the configuration of the S3 location of the output data.
    s_3_output_data_config: ?ModelInvocationJobS3OutputDataConfig,

    pub const json_field_names = .{
        .s_3_output_data_config = "s3OutputDataConfig",
    };
};
