pub const State = enum {
    draft,
    active,
    completed,
    cancelled,
    closed,
    paused,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .active = "ACTIVE",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .closed = "CLOSED",
        .paused = "PAUSED",
    };
};
