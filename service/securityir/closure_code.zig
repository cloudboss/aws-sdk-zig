pub const ClosureCode = enum {
    investigation_completed,
    not_resolved,
    false_positive,
    duplicate,

    pub const json_field_names = .{
        .investigation_completed = "INVESTIGATION_COMPLETED",
        .not_resolved = "NOT_RESOLVED",
        .false_positive = "FALSE_POSITIVE",
        .duplicate = "DUPLICATE",
    };
};
