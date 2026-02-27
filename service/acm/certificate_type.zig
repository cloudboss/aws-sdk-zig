pub const CertificateType = enum {
    imported,
    amazon_issued,
    private,

    pub const json_field_names = .{
        .imported = "IMPORTED",
        .amazon_issued = "AMAZON_ISSUED",
        .private = "PRIVATE",
    };
};
