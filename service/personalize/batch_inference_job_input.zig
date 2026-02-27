const S3DataConfig = @import("s3_data_config.zig").S3DataConfig;

/// The input configuration of a batch inference job.
pub const BatchInferenceJobInput = struct {
    /// The URI of the Amazon S3 location that contains your input data. The Amazon
    /// S3 bucket must be in the
    /// same region as the API endpoint you are calling.
    s_3_data_source: S3DataConfig,

    pub const json_field_names = .{
        .s_3_data_source = "s3DataSource",
    };
};
