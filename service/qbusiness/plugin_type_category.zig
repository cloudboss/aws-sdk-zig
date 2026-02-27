pub const PluginTypeCategory = enum {
    crm,
    project_management,
    communication,
    productivity,
    ticketing_management,

    pub const json_field_names = .{
        .crm = "CRM",
        .project_management = "PROJECT_MANAGEMENT",
        .communication = "COMMUNICATION",
        .productivity = "PRODUCTIVITY",
        .ticketing_management = "TICKETING_MANAGEMENT",
    };
};
