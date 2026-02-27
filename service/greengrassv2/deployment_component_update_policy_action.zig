pub const DeploymentComponentUpdatePolicyAction = enum {
    notify_components,
    skip_notify_components,

    pub const json_field_names = .{
        .notify_components = "NOTIFY_COMPONENTS",
        .skip_notify_components = "SKIP_NOTIFY_COMPONENTS",
    };
};
