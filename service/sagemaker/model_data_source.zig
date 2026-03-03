const S3ModelDataSource = @import("s3_model_data_source.zig").S3ModelDataSource;

/// Specifies the location of ML model data to deploy. If specified, you must
/// specify one and only one of the available data sources.
pub const ModelDataSource = struct {
    /// Specifies the S3 location of ML model data to deploy.
    s3_data_source: ?S3ModelDataSource = null,

    pub const json_field_names = .{
        .s3_data_source = "S3DataSource",
    };
};
