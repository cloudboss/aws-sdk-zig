pub const ClusterEndpointEncryptionType = enum {
    none,
    tls,

    pub const json_field_names = .{
        .none = "NONE",
        .tls = "TLS",
    };
};
