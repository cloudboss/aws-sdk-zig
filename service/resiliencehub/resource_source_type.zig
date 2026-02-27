pub const ResourceSourceType = enum {
    app_template,
    discovered,

    pub const json_field_names = .{
        .app_template = "APP_TEMPLATE",
        .discovered = "DISCOVERED",
    };
};
