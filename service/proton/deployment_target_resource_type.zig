pub const DeploymentTargetResourceType = enum {
    environment,
    service_pipeline,
    service_instance,
    component,

    pub const json_field_names = .{
        .environment = "ENVIRONMENT",
        .service_pipeline = "SERVICE_PIPELINE",
        .service_instance = "SERVICE_INSTANCE",
        .component = "COMPONENT",
    };
};
