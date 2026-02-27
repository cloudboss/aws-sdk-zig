pub const TemplateType = enum {
    environment,
    service,

    pub const json_field_names = .{
        .environment = "ENVIRONMENT",
        .service = "SERVICE",
    };
};
