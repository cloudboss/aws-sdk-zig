pub const IdleFinding = enum {
    idle,
    unattached,
    unused,

    pub const json_field_names = .{
        .idle = "IDLE",
        .unattached = "UNATTACHED",
        .unused = "UNUSED",
    };
};
