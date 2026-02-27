pub const SessionStatus = enum {
    active,
    terminated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .terminated = "TERMINATED",
    };
};
