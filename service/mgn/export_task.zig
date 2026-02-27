const aws = @import("aws");

const ExportStatus = @import("export_status.zig").ExportStatus;
const ExportTaskSummary = @import("export_task_summary.zig").ExportTaskSummary;

/// Export task.
pub const ExportTask = struct {
    /// ExportTask arn.
    arn: ?[]const u8,

    /// Export task creation datetime.
    creation_date_time: ?[]const u8,

    /// Export task end datetime.
    end_date_time: ?[]const u8,

    /// Export task id.
    export_id: ?[]const u8,

    /// Export task progress percentage.
    progress_percentage: ?f32,

    /// Export task s3 bucket.
    s_3_bucket: ?[]const u8,

    /// Export task s3 bucket owner.
    s_3_bucket_owner: ?[]const u8,

    /// Export task s3 key.
    s_3_key: ?[]const u8,

    /// Export task status.
    status: ?ExportStatus,

    /// Export task summary.
    summary: ?ExportTaskSummary,

    /// Export task tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .end_date_time = "endDateTime",
        .export_id = "exportID",
        .progress_percentage = "progressPercentage",
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key = "s3Key",
        .status = "status",
        .summary = "summary",
        .tags = "tags",
    };
};
