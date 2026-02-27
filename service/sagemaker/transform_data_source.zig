const TransformS3DataSource = @import("transform_s3_data_source.zig").TransformS3DataSource;

/// Describes the location of the channel data.
pub const TransformDataSource = struct {
    /// The S3 location of the data source that is associated with a channel.
    s3_data_source: TransformS3DataSource,

    pub const json_field_names = .{
        .s3_data_source = "S3DataSource",
    };
};
