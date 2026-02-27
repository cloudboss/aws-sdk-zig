pub const PropertyValueType = enum {
    plain_text,
    stringified_json,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .stringified_json = "STRINGIFIED_JSON",
    };
};
