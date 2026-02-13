pub const SessionState = enum {
    active,
    history,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .history = "HISTORY",
    };
};
