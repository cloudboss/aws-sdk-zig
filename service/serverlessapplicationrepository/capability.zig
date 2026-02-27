/// Values that must be specified in order to deploy some applications.
pub const Capability = enum {
    capability_iam,
    capability_named_iam,
    capability_auto_expand,
    capability_resource_policy,

    pub const json_field_names = .{
        .capability_iam = "CAPABILITY_IAM",
        .capability_named_iam = "CAPABILITY_NAMED_IAM",
        .capability_auto_expand = "CAPABILITY_AUTO_EXPAND",
        .capability_resource_policy = "CAPABILITY_RESOURCE_POLICY",
    };
};
