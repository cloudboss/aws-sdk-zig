pub const UpdateRecommendationLifecycleStage = enum {
    pending_response,
    in_progress,
    dismissed,
    resolved,

    pub const json_field_names = .{
        .pending_response = "PENDING_RESPONSE",
        .in_progress = "IN_PROGRESS",
        .dismissed = "DISMISSED",
        .resolved = "RESOLVED",
    };
};
