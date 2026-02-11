const ImportStatus = @import("import_status.zig").ImportStatus;
const InputFormat = @import("input_format.zig").InputFormat;
const S3BucketSource = @import("s_3_bucket_source.zig").S3BucketSource;

/// Summary information about the source file for the import.
pub const ImportSummary = struct {
    /// The Amazon Resource Number (ARN) of the Cloudwatch Log Group associated with
    /// this
    /// import task.
    cloud_watch_log_group_arn: ?[]const u8,

    /// The time at which this import task ended. (Does this include the successful
    /// complete
    /// creation of the table it was imported to?)
    end_time: ?i64,

    /// The Amazon Resource Number (ARN) corresponding to the import request.
    import_arn: ?[]const u8,

    /// The status of the import operation.
    import_status: ?ImportStatus,

    /// The format of the source data. Valid values are `CSV`,
    /// `DYNAMODB_JSON` or `ION`.
    input_format: ?InputFormat,

    /// The path and S3 bucket of the source file that is being imported. This
    /// includes the
    /// S3Bucket (required), S3KeyPrefix (optional) and S3BucketOwner (optional if
    /// the bucket is
    /// owned by the requester).
    s_3_bucket_source: ?S3BucketSource,

    /// The time at which this import task began.
    start_time: ?i64,

    /// The Amazon Resource Number (ARN) of the table being imported into.
    table_arn: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "CloudWatchLogGroupArn",
        .end_time = "EndTime",
        .import_arn = "ImportArn",
        .import_status = "ImportStatus",
        .input_format = "InputFormat",
        .s_3_bucket_source = "S3BucketSource",
        .start_time = "StartTime",
        .table_arn = "TableArn",
    };
};
