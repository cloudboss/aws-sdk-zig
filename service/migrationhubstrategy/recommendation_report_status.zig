pub const RecommendationReportStatus = enum {
    failed,
    in_progress,
    success,

    pub const json_field_names = .{
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
    };
};
