pub const EfsInTransitEncryption = enum {
    none,
    tls1_2,

    pub const json_field_names = .{
        .none = "NONE",
        .tls1_2 = "TLS1_2",
    };
};
