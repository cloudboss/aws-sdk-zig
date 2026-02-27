const AutoMLS3DataSource = @import("auto_mls3_data_source.zig").AutoMLS3DataSource;

/// The data source for the Autopilot job.
pub const AutoMLDataSource = struct {
    /// The Amazon S3 location of the input data.
    s3_data_source: AutoMLS3DataSource,

    pub const json_field_names = .{
        .s3_data_source = "S3DataSource",
    };
};
