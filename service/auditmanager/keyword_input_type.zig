pub const KeywordInputType = enum {
    select_from_list,
    upload_file,
    input_text,

    pub const json_field_names = .{
        .select_from_list = "SELECT_FROM_LIST",
        .upload_file = "UPLOAD_FILE",
        .input_text = "INPUT_TEXT",
    };
};
