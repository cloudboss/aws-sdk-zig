pub const EntityType = enum {
    all_personally_identifiable_information,
    numbers,
    custom,

    pub const json_field_names = .{
        .all_personally_identifiable_information = "ALL_PERSONALLY_IDENTIFIABLE_INFORMATION",
        .numbers = "NUMBERS",
        .custom = "CUSTOM",
    };
};
