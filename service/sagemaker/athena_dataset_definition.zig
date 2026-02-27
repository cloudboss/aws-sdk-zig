const AthenaResultCompressionType = @import("athena_result_compression_type.zig").AthenaResultCompressionType;
const AthenaResultFormat = @import("athena_result_format.zig").AthenaResultFormat;

/// Configuration for Athena Dataset Definition input.
pub const AthenaDatasetDefinition = struct {
    catalog: []const u8,

    database: []const u8,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data generated from an Athena query
    /// execution.
    kms_key_id: ?[]const u8,

    output_compression: ?AthenaResultCompressionType,

    output_format: AthenaResultFormat,

    /// The location in Amazon S3 where Athena query results are stored.
    output_s3_uri: []const u8,

    query_string: []const u8,

    work_group: ?[]const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .database = "Database",
        .kms_key_id = "KmsKeyId",
        .output_compression = "OutputCompression",
        .output_format = "OutputFormat",
        .output_s3_uri = "OutputS3Uri",
        .query_string = "QueryString",
        .work_group = "WorkGroup",
    };
};
