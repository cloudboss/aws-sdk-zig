const aws = @import("aws");

const S3BucketSource = @import("s3_bucket_source.zig").S3BucketSource;
const ImportStatus = @import("import_status.zig").ImportStatus;
const ImportTaskSummary = @import("import_task_summary.zig").ImportTaskSummary;

/// Import task.
pub const ImportTask = struct {
    /// ImportTask arn.
    arn: ?[]const u8 = null,

    /// Import task creation datetime.
    creation_date_time: ?[]const u8 = null,

    /// Import task end datetime.
    end_date_time: ?[]const u8 = null,

    /// Import task id.
    import_id: ?[]const u8 = null,

    /// Import task progress percentage.
    progress_percentage: ?f32 = null,

    /// Import task s3 bucket source.
    s_3_bucket_source: ?S3BucketSource = null,

    /// Import task status.
    status: ?ImportStatus = null,

    /// Import task summary.
    summary: ?ImportTaskSummary = null,

    /// Import task tags.
    tags: ?[]const aws.map.StringMapEntry = null,

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
