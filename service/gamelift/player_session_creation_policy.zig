pub const PlayerSessionCreationPolicy = enum {
    accept_all,
    deny_all,

    pub const json_field_names = .{
        .accept_all = "ACCEPT_ALL",
        .deny_all = "DENY_ALL",
    };
};
