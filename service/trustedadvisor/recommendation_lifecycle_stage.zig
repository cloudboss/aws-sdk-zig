pub const RecommendationLifecycleStage = enum {
    in_progress,
    pending_response,
    dismissed,
    resolved,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .pending_response = "PENDING_RESPONSE",
        .dismissed = "DISMISSED",
        .resolved = "RESOLVED",
    };
};
