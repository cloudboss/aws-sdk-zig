pub const RegistrationType = enum {
    intra_eu,
    local,

    pub const json_field_names = .{
        .intra_eu = "INTRA_EU",
        .local = "LOCAL",
    };
};
