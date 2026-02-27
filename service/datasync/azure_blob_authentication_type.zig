pub const AzureBlobAuthenticationType = enum {
    sas,
    none,

    pub const json_field_names = .{
        .sas = "SAS",
        .none = "NONE",
    };
};
