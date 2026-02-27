const DdbExportType = @import("ddb_export_type.zig").DdbExportType;

/// Specifies connection options for DynamoDB ELT (Extract, Load, Transform)
/// operations. This structure contains configuration parameters for connecting
/// to and extracting data from DynamoDB tables using the ELT connector.
pub const DDBELTConnectionOptions = struct {
    /// Specifies the export type for DynamoDB data extraction. This parameter
    /// determines how data is exported from the DynamoDB table during the ELT
    /// process.
    dynamodb_export: ?DdbExportType,

    /// The name of the Amazon S3 bucket used for intermediate storage during the
    /// DynamoDB ELT process. This bucket is used to temporarily store exported
    /// DynamoDB data before it is processed by the ELT job.
    dynamodb_s3_bucket: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the S3 bucket specified
    /// in `DynamodbS3Bucket`. This parameter is required when the S3 bucket is
    /// owned by
    /// a different Amazon Web Services account than the one running the ELT job,
    /// enabling cross-account access to the intermediate storage bucket.
    dynamodb_s3_bucket_owner: ?[]const u8,

    /// The S3 object key prefix for files stored in the intermediate S3 bucket
    /// during the DynamoDB ELT process. This prefix helps organize and identify the
    /// temporary files created during data extraction.
    dynamodb_s3_prefix: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Security Token
    /// Service (STS) role to assume for accessing DynamoDB and S3 resources during
    /// the ELT operation.
    /// This role must have the necessary permissions to read from the DynamoDB
    /// table and write to the intermediate S3 bucket.
    dynamodb_sts_role_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the DynamoDB table to extract data from.
    /// This parameter specifies the source table for the ELT operation.
    dynamodb_table_arn: []const u8,

    /// A boolean value that specifies whether to unnest DynamoDB JSON format during
    /// data extraction. When set to `true`, the connector will
    /// flatten nested JSON structures from DynamoDB items. When set to `false`, the
    /// original DynamoDB JSON structure is preserved.
    dynamodb_unnest_ddb_json: bool = false,

    pub const json_field_names = .{
        .dynamodb_export = "DynamodbExport",
        .dynamodb_s3_bucket = "DynamodbS3Bucket",
        .dynamodb_s3_bucket_owner = "DynamodbS3BucketOwner",
        .dynamodb_s3_prefix = "DynamodbS3Prefix",
        .dynamodb_sts_role_arn = "DynamodbStsRoleArn",
        .dynamodb_table_arn = "DynamodbTableArn",
        .dynamodb_unnest_ddb_json = "DynamodbUnnestDDBJson",
    };
};
