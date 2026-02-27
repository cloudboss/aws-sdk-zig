pub const ShareRequestAction = enum {
    accept,
    decline,
    revoke,

    pub const json_field_names = .{
        .accept = "ACCEPT",
        .decline = "DECLINE",
        .revoke = "REVOKE",
    };
};
