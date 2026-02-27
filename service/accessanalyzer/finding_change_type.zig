pub const FindingChangeType = enum {
    changed,
    new,
    unchanged,

    pub const json_field_names = .{
        .changed = "CHANGED",
        .new = "NEW",
        .unchanged = "UNCHANGED",
    };
};
