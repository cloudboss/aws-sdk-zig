/// Provides information about additional attributes for the load balancer.
pub const AwsElbLoadBalancerAdditionalAttribute = struct {
    /// The name of the attribute.
    key: ?[]const u8 = null,

    /// The value of the attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
