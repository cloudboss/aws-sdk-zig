pub const Scope = enum {
    profile,
    domain,

    pub const json_field_names = .{
        .profile = "PROFILE",
        .domain = "DOMAIN",
    };
};
