const S3DataConfig = @import("s3_data_config.zig").S3DataConfig;

/// The output configuration parameters of a batch inference job.
pub const BatchInferenceJobOutput = struct {
    /// Information on the Amazon S3 bucket in which the batch inference job's
    /// output is stored.
    s_3_data_destination: S3DataConfig,

    pub const json_field_names = .{
        .s_3_data_destination = "s3DataDestination",
    };
};
