pub const RuleBasedMatchingStatus = enum {
    pending,
    in_progress,
    active,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .active = "ACTIVE",
    };
};
