pub const QueueStatus = enum {
    idle,
    scheduling,
    scheduling_blocked,

    pub const json_field_names = .{
        .idle = "IDLE",
        .scheduling = "SCHEDULING",
        .scheduling_blocked = "SCHEDULING_BLOCKED",
    };
};
