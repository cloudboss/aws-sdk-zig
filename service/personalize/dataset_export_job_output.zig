const S3DataConfig = @import("s3_data_config.zig").S3DataConfig;

/// The output configuration parameters of a dataset export job.
pub const DatasetExportJobOutput = struct {
    s_3_data_destination: S3DataConfig,

    pub const json_field_names = .{
        .s_3_data_destination = "s3DataDestination",
    };
};
