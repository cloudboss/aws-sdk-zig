pub const CertificateAuthorityType = enum {
    root,
    subordinate,

    pub const json_field_names = .{
        .root = "ROOT",
        .subordinate = "SUBORDINATE",
    };
};
