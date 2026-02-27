pub const DataLabelContent = enum {
    value,
    percent,
    value_and_percent,

    pub const json_field_names = .{
        .value = "VALUE",
        .percent = "PERCENT",
        .value_and_percent = "VALUE_AND_PERCENT",
    };
};
