pub const ScalingPolicyUpdateBehavior = enum {
    keep_external_policies,
    replace_external_policies,

    pub const json_field_names = .{
        .keep_external_policies = "KeepExternalPolicies",
        .replace_external_policies = "ReplaceExternalPolicies",
    };
};
