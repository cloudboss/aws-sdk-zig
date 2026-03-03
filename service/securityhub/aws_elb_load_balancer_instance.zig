/// Provides information about an EC2 instance for a load balancer.
pub const AwsElbLoadBalancerInstance = struct {
    /// The instance identifier.
    instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
    };
};
