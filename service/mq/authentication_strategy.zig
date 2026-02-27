/// Optional. The authentication strategy used to secure the broker. The default
/// is SIMPLE.
pub const AuthenticationStrategy = enum {
    simple,
    ldap,
    config_managed,

    pub const json_field_names = .{
        .simple = "SIMPLE",
        .ldap = "LDAP",
        .config_managed = "CONFIG_MANAGED",
    };
};
