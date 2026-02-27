pub const CmafEncryptionMethod = enum {
    cenc,
    cbcs,

    pub const json_field_names = .{
        .cenc = "CENC",
        .cbcs = "CBCS",
    };
};
