pub const ContainerServiceStateDetailCode = enum {
    creating_system_resources,
    creating_network_infrastructure,
    provisioning_certificate,
    provisioning_service,
    creating_deployment,
    evaluating_health_check,
    activating_deployment,
    certificate_limit_exceeded,
    unknown_error,

    pub const json_field_names = .{
        .creating_system_resources = "CREATING_SYSTEM_RESOURCES",
        .creating_network_infrastructure = "CREATING_NETWORK_INFRASTRUCTURE",
        .provisioning_certificate = "PROVISIONING_CERTIFICATE",
        .provisioning_service = "PROVISIONING_SERVICE",
        .creating_deployment = "CREATING_DEPLOYMENT",
        .evaluating_health_check = "EVALUATING_HEALTH_CHECK",
        .activating_deployment = "ACTIVATING_DEPLOYMENT",
        .certificate_limit_exceeded = "CERTIFICATE_LIMIT_EXCEEDED",
        .unknown_error = "UNKNOWN_ERROR",
    };
};
