pub const HdfsAuthenticationType = enum {
    simple,
    kerberos,

    pub const json_field_names = .{
        .simple = "SIMPLE",
        .kerberos = "KERBEROS",
    };
};
