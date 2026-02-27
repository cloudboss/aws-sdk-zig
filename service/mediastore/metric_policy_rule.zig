/// A setting that enables metrics at the object level. Each rule contains an
/// object group and an object group name. If the policy includes the
/// MetricPolicyRules parameter, you must include at least one rule. Each metric
/// policy can include up to five rules by default. You can also [request a
/// quota
/// increase](https://console.aws.amazon.com/servicequotas/home?region=us-east-1#!/services/mediastore/quotas) to allow up to 300 rules per policy.
pub const MetricPolicyRule = struct {
    /// A path or file name that defines which objects to include in the group.
    /// Wildcards (*) are acceptable.
    object_group: []const u8,

    /// A name that allows you to refer to the object group.
    object_group_name: []const u8,

    pub const json_field_names = .{
        .object_group = "ObjectGroup",
        .object_group_name = "ObjectGroupName",
    };
};
