/// A load balancer attribute.
pub const AwsElbv2LoadBalancerAttribute = struct {
    /// The name of the load balancer attribute.
    key: ?[]const u8 = null,

    /// The value of the load balancer attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
