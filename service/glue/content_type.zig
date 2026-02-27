pub const ContentType = enum {
    application_json,
    url_encoded,

    pub const json_field_names = .{
        .application_json = "APPLICATION_JSON",
        .url_encoded = "URL_ENCODED",
    };
};
