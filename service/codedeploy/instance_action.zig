pub const InstanceAction = enum {
    terminate,
    keep_alive,

    pub const json_field_names = .{
        .terminate = "TERMINATE",
        .keep_alive = "KEEP_ALIVE",
    };
};
