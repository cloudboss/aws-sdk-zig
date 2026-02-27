pub const FieldType = enum {
    text,
    number,
    boolean,
    date_time,
    single_select,
    url,
    user,

    pub const json_field_names = .{
        .text = "TEXT",
        .number = "NUMBER",
        .boolean = "BOOLEAN",
        .date_time = "DATE_TIME",
        .single_select = "SINGLE_SELECT",
        .url = "URL",
        .user = "USER",
    };
};
