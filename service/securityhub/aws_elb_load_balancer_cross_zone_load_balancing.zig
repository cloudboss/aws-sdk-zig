/// Contains cross-zone load balancing settings for the load balancer.
pub const AwsElbLoadBalancerCrossZoneLoadBalancing = struct {
    /// Indicates whether cross-zone load balancing is enabled for the load
    /// balancer.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
