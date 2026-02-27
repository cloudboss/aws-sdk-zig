const aws = @import("aws");

const S3BucketSource = @import("s3_bucket_source.zig").S3BucketSource;
const ImportStatus = @import("import_status.zig").ImportStatus;
const ImportTaskSummary = @import("import_task_summary.zig").ImportTaskSummary;

/// Import task.
pub const ImportTask = struct {
    /// ImportTask arn.
    arn: ?[]const u8,

    /// Import task creation datetime.
    creation_date_time: ?[]const u8,

    /// Import task end datetime.
    end_date_time: ?[]const u8,

    /// Import task id.
    import_id: ?[]const u8,

    /// Import task progress percentage.
    progress_percentage: ?f32,

    /// Import task s3 bucket source.
    s_3_bucket_source: ?S3BucketSource,

    /// Import task status.
    status: ?ImportStatus,

    /// Import task summary.
    summary: ?ImportTaskSummary,

    /// Import task tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .end_date_time = "endDateTime",
        .import_id = "importID",
        .progress_percentage = "progressPercentage",
        .s_3_bucket_source = "s3BucketSource",
        .status = "status",
        .summary = "summary",
        .tags = "tags",
    };
};
