pub const ListServiceInstancesFilterBy = enum {
    name,
    deployment_status,
    template_name,
    service_name,
    deployed_template_version_status,
    environment_name,
    last_deployment_attempted_at_before,
    last_deployment_attempted_at_after,
    created_at_before,
    created_at_after,

    pub const json_field_names = .{
        .name = "NAME",
        .deployment_status = "DEPLOYMENT_STATUS",
        .template_name = "TEMPLATE_NAME",
        .service_name = "SERVICE_NAME",
        .deployed_template_version_status = "DEPLOYED_TEMPLATE_VERSION_STATUS",
        .environment_name = "ENVIRONMENT_NAME",
        .last_deployment_attempted_at_before = "LAST_DEPLOYMENT_ATTEMPTED_AT_BEFORE",
        .last_deployment_attempted_at_after = "LAST_DEPLOYMENT_ATTEMPTED_AT_AFTER",
        .created_at_before = "CREATED_AT_BEFORE",
        .created_at_after = "CREATED_AT_AFTER",
    };
};
