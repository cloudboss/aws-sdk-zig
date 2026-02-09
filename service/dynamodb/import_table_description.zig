const ImportStatus = @import("import_status.zig").ImportStatus;
const InputCompressionType = @import("input_compression_type.zig").InputCompressionType;
const InputFormat = @import("input_format.zig").InputFormat;
const InputFormatOptions = @import("input_format_options.zig").InputFormatOptions;
const S3BucketSource = @import("s_3_bucket_source.zig").S3BucketSource;
const TableCreationParameters = @import("table_creation_parameters.zig").TableCreationParameters;

/// Represents the properties of the table being imported into.
pub const ImportTableDescription = struct {
    /// The client token that was provided for the import task. Reusing the client
    /// token on
    /// retry makes a call to `ImportTable` idempotent.
    client_token: ?[]const u8,

    /// The Amazon Resource Number (ARN) of the Cloudwatch Log Group associated with
    /// the
    /// target table.
    cloud_watch_log_group_arn: ?[]const u8,

    /// The time at which the creation of the table associated with this import task
    /// completed.
    end_time: ?i64,

    /// The number of errors occurred on importing the source file into the target
    /// table.
    error_count: ?i64,

    /// The error code corresponding to the failure that the import job ran into
    /// during
    /// execution.
    failure_code: ?[]const u8,

    /// The error message corresponding to the failure that the import job ran into
    /// during
    /// execution.
    failure_message: ?[]const u8,

    /// The Amazon Resource Number (ARN) corresponding to the import request.
    import_arn: ?[]const u8,

    /// The number of items successfully imported into the new table.
    imported_item_count: ?i64,

    /// The status of the import.
    import_status: ?ImportStatus,

    /// The compression options for the data that has been imported into the target
    /// table.
    /// The values are NONE, GZIP, or ZSTD.
    input_compression_type: ?InputCompressionType,

    /// The format of the source data going into the target table.
    input_format: ?InputFormat,

    /// The format options for the data that was imported into the target table.
    /// There is one
    /// value, CsvOption.
    input_format_options: ?InputFormatOptions,

    /// The total number of items processed from the source file.
    processed_item_count: ?i64,

    /// The total size of data processed from the source file, in Bytes.
    processed_size_bytes: ?i64,

    /// Values for the S3 bucket the source file is imported from. Includes bucket
    /// name
    /// (required), key prefix (optional) and bucket account owner ID (optional).
    s_3_bucket_source: ?S3BucketSource,

    /// The time when this import task started.
    start_time: ?i64,

    /// The Amazon Resource Number (ARN) of the table being imported into.
    table_arn: ?[]const u8,

    /// The parameters for the new table that is being imported into.
    table_creation_parameters: ?TableCreationParameters,

    /// The table id corresponding to the table created by import table process.
    table_id: ?[]const u8,
};
