pub const DocumentAttributeValueType = enum {
    string_value,
    string_list_value,
    long_value,
    date_value,

    pub const json_field_names = .{
        .string_value = "STRING_VALUE",
        .string_list_value = "STRING_LIST_VALUE",
        .long_value = "LONG_VALUE",
        .date_value = "DATE_VALUE",
    };
};
