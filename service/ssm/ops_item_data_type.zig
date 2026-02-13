pub const OpsItemDataType = enum {
    searchable_string,
    string,

    pub const json_field_names = .{
        .searchable_string = "SEARCHABLE_STRING",
        .string = "STRING",
    };
};
