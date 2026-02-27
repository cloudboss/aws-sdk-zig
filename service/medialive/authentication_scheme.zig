/// Authentication Scheme
pub const AuthenticationScheme = enum {
    akamai,
    common,

    pub const json_field_names = .{
        .akamai = "AKAMAI",
        .common = "COMMON",
    };
};
