const S3DataConfig = @import("s3_data_config.zig").S3DataConfig;

/// The input configuration of a batch segment job.
pub const BatchSegmentJobInput = struct {
    s_3_data_source: S3DataConfig,

    pub const json_field_names = .{
        .s_3_data_source = "s3DataSource",
    };
};
