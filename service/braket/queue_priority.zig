pub const QueuePriority = enum {
    normal,
    priority,

    pub const json_field_names = .{
        .normal = "NORMAL",
        .priority = "PRIORITY",
    };
};
