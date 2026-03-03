const RedshiftResultCompressionType = @import("redshift_result_compression_type.zig").RedshiftResultCompressionType;
const RedshiftResultFormat = @import("redshift_result_format.zig").RedshiftResultFormat;

/// Configuration for Redshift Dataset Definition input.
pub const RedshiftDatasetDefinition = struct {
    cluster_id: []const u8,

    /// The IAM role attached to your Redshift cluster that Amazon SageMaker uses to
    /// generate datasets.
    cluster_role_arn: []const u8,

    database: []const u8,

    db_user: []const u8,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data from a Redshift execution.
    kms_key_id: ?[]const u8 = null,

    output_compression: ?RedshiftResultCompressionType = null,

    output_format: RedshiftResultFormat,

    /// The location in Amazon S3 where the Redshift query results are stored.
    output_s3_uri: []const u8,

    query_string: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .cluster_role_arn = "ClusterRoleArn",
        .database = "Database",
        .db_user = "DbUser",
        .kms_key_id = "KmsKeyId",
        .output_compression = "OutputCompression",
        .output_format = "OutputFormat",
        .output_s3_uri = "OutputS3Uri",
        .query_string = "QueryString",
    };
};
