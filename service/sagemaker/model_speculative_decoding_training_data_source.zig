const ModelSpeculativeDecodingS3DataType = @import("model_speculative_decoding_s3_data_type.zig").ModelSpeculativeDecodingS3DataType;

/// Contains information about the training data source for speculative
/// decoding.
pub const ModelSpeculativeDecodingTrainingDataSource = struct {
    /// The type of data stored in the Amazon S3 location. Valid values are
    /// `S3Prefix` or `ManifestFile`.
    s3_data_type: ModelSpeculativeDecodingS3DataType,

    /// The Amazon S3 URI that points to the training data for speculative decoding.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_data_type = "S3DataType",
        .s3_uri = "S3Uri",
    };
};
