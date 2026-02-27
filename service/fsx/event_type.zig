pub const EventType = enum {
    new,
    changed,
    deleted,

    pub const json_field_names = .{
        .new = "NEW",
        .changed = "CHANGED",
        .deleted = "DELETED",
    };
};
