const AsyncInvokeS3OutputDataConfig = @import("async_invoke_s3_output_data_config.zig").AsyncInvokeS3OutputDataConfig;

/// Asynchronous invocation output data settings.
pub const AsyncInvokeOutputDataConfig = union(enum) {
    /// A storage location for the output data in an S3 bucket
    s_3_output_data_config: ?AsyncInvokeS3OutputDataConfig,

    pub const json_field_names = .{
        .s_3_output_data_config = "s3OutputDataConfig",
    };
};
