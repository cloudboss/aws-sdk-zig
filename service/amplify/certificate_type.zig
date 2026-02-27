pub const CertificateType = enum {
    amplify_managed,
    custom,

    pub const json_field_names = .{
        .amplify_managed = "AMPLIFY_MANAGED",
        .custom = "CUSTOM",
    };
};
