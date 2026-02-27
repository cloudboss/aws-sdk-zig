pub const CertificateType = enum {
    disabled,
    generated,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .generated = "Generated",
    };
};
