pub const ResponseContentType = enum {
    text_plain,
    text_html,
    application_json,

    pub const json_field_names = .{
        .text_plain = "TEXT_PLAIN",
        .text_html = "TEXT_HTML",
        .application_json = "APPLICATION_JSON",
    };
};
