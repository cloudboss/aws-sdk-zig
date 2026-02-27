pub const ContentType = enum {
    application_json,
    application_xml,

    pub const json_field_names = .{
        .application_json = "application_json",
        .application_xml = "application_xml",
    };
};
