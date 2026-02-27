pub const CatalogEncryptionMode = enum {
    disabled,
    ssekms,
    ssekmswithservicerole,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .ssekms = "SSEKMS",
        .ssekmswithservicerole = "SSEKMSWITHSERVICEROLE",
    };
};
