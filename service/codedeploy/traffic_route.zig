/// Information about a listener. The listener contains the path used to route
/// traffic
/// that is received from the load balancer to a target group.
pub const TrafficRoute = struct {
    /// The Amazon Resource Name (ARN) of one listener. The listener identifies the
    /// route
    /// between a target group and a load balancer. This is an array of strings with
    /// a maximum
    /// size of one.
    listener_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .listener_arns = "listenerArns",
    };
};
