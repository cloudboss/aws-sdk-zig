const ImportStatus = @import("import_status.zig").ImportStatus;
const InputCompressionType = @import("input_compression_type.zig").InputCompressionType;
const InputFormat = @import("input_format.zig").InputFormat;
const InputFormatOptions = @import("input_format_options.zig").InputFormatOptions;
const S3BucketSource = @import("s3_bucket_source.zig").S3BucketSource;
const TableCreationParameters = @import("table_creation_parameters.zig").TableCreationParameters;

/// Represents the properties of the table being imported into.
pub const ImportTableDescription = struct {
    /// The client token that was provided for the import task. Reusing the client
    /// token on
    /// retry makes a call to `ImportTable` idempotent.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the Cloudwatch Log Group associated with
    /// the
    /// target table.
    cloud_watch_log_group_arn: ?[]const u8 = null,

    /// The time at which the creation of the table associated with this import task
    /// completed.
    end_time: ?i64 = null,

    /// The number of errors occurred on importing the source file into the target
    /// table.
    error_count: i64 = 0,

    /// The error code corresponding to the failure that the import job ran into
    /// during
    /// execution.
    failure_code: ?[]const u8 = null,

    /// The error message corresponding to the failure that the import job ran into
    /// during
    /// execution.
    failure_message: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) corresponding to the import request.
    import_arn: ?[]const u8 = null,

    /// The number of items successfully imported into the new table.
    imported_item_count: i64 = 0,

    /// The status of the import.
    import_status: ?ImportStatus = null,

    /// The compression options for the data that has been imported into the target
    /// table.
    /// The values are NONE, GZIP, or ZSTD.
    input_compression_type: ?InputCompressionType = null,

    /// The format of the source data going into the target table.
    input_format: ?InputFormat = null,

    /// The format options for the data that was imported into the target table.
    /// There is one
    /// value, CsvOption.
    input_format_options: ?InputFormatOptions = null,

    /// The total number of items processed from the source file.
    processed_item_count: i64 = 0,

    /// The total size of data processed from the source file, in Bytes.
    processed_size_bytes: ?i64 = null,

    /// Values for the S3 bucket the source file is imported from. Includes bucket
    /// name
    /// (required), key prefix (optional) and bucket account owner ID (optional).
    s3_bucket_source: ?S3BucketSource = null,

    /// The time when this import task started.
    start_time: ?i64 = null,

    /// The Amazon Resource Number (ARN) of the table being imported into.
    table_arn: ?[]const u8 = null,

    /// The parameters for the new table that is being imported into.
    table_creation_parameters: ?TableCreationParameters = null,

    /// The table id corresponding to the table created by import table process.
    table_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .cloud_watch_log_group_arn = "CloudWatchLogGroupArn",
        .end_time = "EndTime",
        .error_count = "ErrorCount",
        .failure_code = "FailureCode",
        .failure_message = "FailureMessage",
        .import_arn = "ImportArn",
        .imported_item_count = "ImportedItemCount",
        .import_status = "ImportStatus",
        .input_compression_type = "InputCompressionType",
        .input_format = "InputFormat",
        .input_format_options = "InputFormatOptions",
        .processed_item_count = "ProcessedItemCount",
        .processed_size_bytes = "ProcessedSizeBytes",
        .s3_bucket_source = "S3BucketSource",
        .start_time = "StartTime",
        .table_arn = "TableArn",
        .table_creation_parameters = "TableCreationParameters",
        .table_id = "TableId",
    };
};
