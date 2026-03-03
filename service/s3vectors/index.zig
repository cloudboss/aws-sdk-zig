const DataType = @import("data_type.zig").DataType;
const DistanceMetric = @import("distance_metric.zig").DistanceMetric;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;

/// The attributes of a vector index.
pub const Index = struct {
    /// Date and time when the vector index was created.
    creation_time: i64,

    /// The data type of the vectors inserted into the vector index.
    data_type: DataType,

    /// The number of values in the vectors that are inserted into the vector index.
    dimension: i32,

    /// The distance metric to be used for similarity search.
    distance_metric: DistanceMetric,

    /// The encryption configuration for a vector index. By default, if you don't
    /// specify, all new vectors in the vector index will use the encryption
    /// configuration of the vector bucket.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the vector index.
    index_arn: []const u8,

    /// The name of the vector index.
    index_name: []const u8,

    /// The metadata configuration for the vector index.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The name of the vector bucket that contains the vector index.
    vector_bucket_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .data_type = "dataType",
        .dimension = "dimension",
        .distance_metric = "distanceMetric",
        .encryption_configuration = "encryptionConfiguration",
        .index_arn = "indexArn",
        .index_name = "indexName",
        .metadata_configuration = "metadataConfiguration",
        .vector_bucket_name = "vectorBucketName",
    };
};
