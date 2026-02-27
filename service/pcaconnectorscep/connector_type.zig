pub const ConnectorType = enum {
    general_purpose,
    intune,

    pub const json_field_names = .{
        .general_purpose = "GENERAL_PURPOSE",
        .intune = "INTUNE",
    };
};
