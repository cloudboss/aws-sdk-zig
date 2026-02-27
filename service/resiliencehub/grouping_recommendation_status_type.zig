pub const GroupingRecommendationStatusType = enum {
    accepted,
    rejected,
    pending_decision,

    pub const json_field_names = .{
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .pending_decision = "PENDING_DECISION",
    };
};
