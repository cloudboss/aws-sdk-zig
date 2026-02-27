const CompressionType = @import("compression_type.zig").CompressionType;
const AdditionalS3DataSourceDataType = @import("additional_s3_data_source_data_type.zig").AdditionalS3DataSourceDataType;

/// A data source used for training or inference that is in addition to the
/// input dataset or model data.
pub const AdditionalS3DataSource = struct {
    /// The type of compression used for an additional data source used in inference
    /// or training. Specify `None` if your additional data source is not
    /// compressed.
    compression_type: ?CompressionType,

    /// The ETag associated with S3 URI.
    e_tag: ?[]const u8,

    /// The data type of the additional data source that you specify for use in
    /// inference or training.
    s3_data_type: AdditionalS3DataSourceDataType,

    /// The uniform resource identifier (URI) used to identify an additional data
    /// source used in inference or training.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .compression_type = "CompressionType",
        .e_tag = "ETag",
        .s3_data_type = "S3DataType",
        .s3_uri = "S3Uri",
    };
};
