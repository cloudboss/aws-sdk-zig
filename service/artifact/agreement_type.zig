pub const AgreementType = enum {
    custom,
    default,
    modified,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .default = "DEFAULT",
        .modified = "MODIFIED",
    };
};
