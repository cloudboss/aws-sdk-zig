pub const CardType = enum {
    text_input,
    q_query,
    file_upload,
    q_plugin,
    form_input,

    pub const json_field_names = .{
        .text_input = "TEXT_INPUT",
        .q_query = "Q_QUERY",
        .file_upload = "FILE_UPLOAD",
        .q_plugin = "Q_PLUGIN",
        .form_input = "FORM_INPUT",
    };
};
