pub const DataTableAttributeValueType = enum {
    text,
    number,
    boolean,
    text_list,
    number_list,

    pub const json_field_names = .{
        .text = "TEXT",
        .number = "NUMBER",
        .boolean = "BOOLEAN",
        .text_list = "TEXT_LIST",
        .number_list = "NUMBER_LIST",
    };
};
