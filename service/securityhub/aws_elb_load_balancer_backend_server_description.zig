/// Provides information about the configuration of an EC2 instance for the load
/// balancer.
pub const AwsElbLoadBalancerBackendServerDescription = struct {
    /// The port on which the EC2 instance is listening.
    instance_port: ?i32,

    /// The names of the policies that are enabled for the EC2 instance.
    policy_names: ?[]const []const u8,

    pub const json_field_names = .{
        .instance_port = "InstancePort",
        .policy_names = "PolicyNames",
    };
};
