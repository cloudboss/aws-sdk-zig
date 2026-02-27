pub const OverrideStatus = enum {
    override,
    revoke,

    pub const json_field_names = .{
        .override = "OVERRIDE",
        .revoke = "REVOKE",
    };
};
