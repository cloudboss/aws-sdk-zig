pub const FieldType = enum {
    select,
    text,
    attachment,

    pub const json_field_names = .{
        .select = "SELECT",
        .text = "TEXT",
        .attachment = "ATTACHMENT",
    };
};
