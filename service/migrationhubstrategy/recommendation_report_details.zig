const RecommendationReportStatus = @import("recommendation_report_status.zig").RecommendationReportStatus;

/// Contains detailed information about a recommendation report.
pub const RecommendationReportDetails = struct {
    /// The time that the recommendation report generation task completes.
    completion_time: ?i64,

    /// The S3 bucket where the report file is located.
    s_3_bucket: ?[]const u8,

    /// The Amazon S3 key name of the report file.
    s_3_keys: ?[]const []const u8,

    /// The time that the recommendation report generation task starts.
    start_time: ?i64,

    /// The status of the recommendation report generation task.
    status: ?RecommendationReportStatus,

    /// The status message for recommendation report generation.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .s_3_bucket = "s3Bucket",
        .s_3_keys = "s3Keys",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
    };
};
