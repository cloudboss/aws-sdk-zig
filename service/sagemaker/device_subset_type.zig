pub const DeviceSubsetType = enum {
    percentage,
    selection,
    name_contains,

    pub const json_field_names = .{
        .percentage = "Percentage",
        .selection = "Selection",
        .name_contains = "NameContains",
    };
};
