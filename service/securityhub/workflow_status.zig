pub const WorkflowStatus = enum {
    new,
    notified,
    resolved,
    suppressed,

    pub const json_field_names = .{
        .new = "NEW",
        .notified = "NOTIFIED",
        .resolved = "RESOLVED",
        .suppressed = "SUPPRESSED",
    };
};
