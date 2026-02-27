pub const PolicyType = enum {
    identity_policy,
    resource_policy,
    service_control_policy,
    resource_control_policy,

    pub const json_field_names = .{
        .identity_policy = "IDENTITY_POLICY",
        .resource_policy = "RESOURCE_POLICY",
        .service_control_policy = "SERVICE_CONTROL_POLICY",
        .resource_control_policy = "RESOURCE_CONTROL_POLICY",
    };
};
