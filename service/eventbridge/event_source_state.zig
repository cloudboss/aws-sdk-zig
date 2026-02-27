pub const EventSourceState = enum {
    pending,
    active,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .deleted = "DELETED",
    };
};
