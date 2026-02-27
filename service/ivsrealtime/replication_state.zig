pub const ReplicationState = enum {
    active,
    stopped,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .stopped = "STOPPED",
    };
};
