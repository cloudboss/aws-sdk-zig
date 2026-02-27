pub const AccessCheckPolicyType = enum {
    identity_policy,
    resource_policy,

    pub const json_field_names = .{
        .identity_policy = "IDENTITY_POLICY",
        .resource_policy = "RESOURCE_POLICY",
    };
};
