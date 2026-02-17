const ExportFormat = @import("export_format.zig").ExportFormat;
const ExportStatus = @import("export_status.zig").ExportStatus;
const ExportType = @import("export_type.zig").ExportType;
const IncrementalExportSpecification = @import("incremental_export_specification.zig").IncrementalExportSpecification;
const S3SseAlgorithm = @import("s3_sse_algorithm.zig").S3SseAlgorithm;

/// Represents the properties of the exported table.
pub const ExportDescription = struct {
    /// The billable size of the table export.
    billed_size_bytes: ?i64,

    /// The client token that was provided for the export task. A client token makes
    /// calls to
    /// `ExportTableToPointInTimeInput` idempotent, meaning that multiple
    /// identical calls have the same effect as one single call.
    client_token: ?[]const u8,

    /// The time at which the export task completed.
    end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the table export.
    export_arn: ?[]const u8,

    /// The format of the exported data. Valid values for `ExportFormat` are
    /// `DYNAMODB_JSON` or `ION`.
    export_format: ?ExportFormat,

    /// The name of the manifest file for the export task.
    export_manifest: ?[]const u8,

    /// Export can be in one of the following states: IN_PROGRESS, COMPLETED, or
    /// FAILED.
    export_status: ?ExportStatus,

    /// Point in time from which table data was exported.
    export_time: ?i64,

    /// The type of export that was performed. Valid values are `FULL_EXPORT` or
    /// `INCREMENTAL_EXPORT`.
    export_type: ?ExportType,

    /// Status code for the result of the failed export.
    failure_code: ?[]const u8,

    /// Export failure reason description.
    failure_message: ?[]const u8,

    /// Optional object containing the parameters specific to an incremental export.
    incremental_export_specification: ?IncrementalExportSpecification,

    /// The number of items exported.
    item_count: ?i64,

    /// The name of the Amazon S3 bucket containing the export.
    s3_bucket: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the bucket containing
    /// the
    /// export.
    s3_bucket_owner: ?[]const u8,

    /// The Amazon S3 bucket prefix used as the file name and path of the exported
    /// snapshot.
    s3_prefix: ?[]const u8,

    /// Type of encryption used on the bucket where export data is stored. Valid
    /// values for
    /// `S3SseAlgorithm` are:
    ///
    /// * `AES256` - server-side encryption with Amazon S3 managed
    /// keys
    ///
    /// * `KMS` - server-side encryption with KMS managed
    /// keys
    s3_sse_algorithm: ?S3SseAlgorithm,

    /// The ID of the KMS managed key used to encrypt the S3 bucket where
    /// export data is stored (if applicable).
    s3_sse_kms_key_id: ?[]const u8,

    /// The time at which the export task began.
    start_time: ?i64,

    /// The Amazon Resource Name (ARN) of the table that was exported.
    table_arn: ?[]const u8,

    /// Unique ID of the table that was exported.
    table_id: ?[]const u8,

    pub const json_field_names = .{
        .billed_size_bytes = "BilledSizeBytes",
        .client_token = "ClientToken",
        .end_time = "EndTime",
        .export_arn = "ExportArn",
        .export_format = "ExportFormat",
        .export_manifest = "ExportManifest",
        .export_status = "ExportStatus",
        .export_time = "ExportTime",
        .export_type = "ExportType",
        .failure_code = "FailureCode",
        .failure_message = "FailureMessage",
        .incremental_export_specification = "IncrementalExportSpecification",
        .item_count = "ItemCount",
        .s3_bucket = "S3Bucket",
        .s3_bucket_owner = "S3BucketOwner",
        .s3_prefix = "S3Prefix",
        .s3_sse_algorithm = "S3SseAlgorithm",
        .s3_sse_kms_key_id = "S3SseKmsKeyId",
        .start_time = "StartTime",
        .table_arn = "TableArn",
        .table_id = "TableId",
    };
};
