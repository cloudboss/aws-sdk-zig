pub const NotificationRole = enum {
    project_owner,
    project_contributor,
    project_viewer,
    domain_owner,
    project_subscriber,

    pub const json_field_names = .{
        .project_owner = "PROJECT_OWNER",
        .project_contributor = "PROJECT_CONTRIBUTOR",
        .project_viewer = "PROJECT_VIEWER",
        .domain_owner = "DOMAIN_OWNER",
        .project_subscriber = "PROJECT_SUBSCRIBER",
    };
};
