/// The resolved load balancer configuration for a service revision. This
/// includes information about which target groups serve traffic and which
/// listener rules direct traffic to them.
pub const ServiceRevisionLoadBalancer = struct {
    /// The Amazon Resource Name (ARN) of the production listener rule or listener
    /// that directs traffic to the target group associated with the service
    /// revision.
    production_listener_rule: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the target group associated with the
    /// service revision.
    target_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .production_listener_rule = "productionListenerRule",
        .target_group_arn = "targetGroupArn",
    };
};
