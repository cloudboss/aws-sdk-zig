pub const ListServiceInstancesSortBy = enum {
    name,
    deployment_status,
    template_name,
    service_name,
    environment_name,
    last_deployment_attempted_at,
    created_at,

    pub const json_field_names = .{
        .name = "NAME",
        .deployment_status = "DEPLOYMENT_STATUS",
        .template_name = "TEMPLATE_NAME",
        .service_name = "SERVICE_NAME",
        .environment_name = "ENVIRONMENT_NAME",
        .last_deployment_attempted_at = "LAST_DEPLOYMENT_ATTEMPTED_AT",
        .created_at = "CREATED_AT",
    };
};
