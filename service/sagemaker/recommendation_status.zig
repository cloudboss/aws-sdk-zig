pub const RecommendationStatus = enum {
    in_progress,
    completed,
    failed,
    not_applicable,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .not_applicable = "NOT_APPLICABLE",
    };
};
