pub const DriftType = enum {
    application_compliance,
    app_component_resiliency_compliance_status,

    pub const json_field_names = .{
        .application_compliance = "APPLICATION_COMPLIANCE",
        .app_component_resiliency_compliance_status = "APP_COMPONENT_RESILIENCY_COMPLIANCE_STATUS",
    };
};
