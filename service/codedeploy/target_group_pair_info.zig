const TrafficRoute = @import("traffic_route.zig").TrafficRoute;
const TargetGroupInfo = @import("target_group_info.zig").TargetGroupInfo;

/// Information about two target groups and how traffic is routed during an
/// Amazon ECS deployment. An optional test traffic route can be specified.
pub const TargetGroupPairInfo = struct {
    /// The path used by a load balancer to route production traffic when an Amazon
    /// ECS deployment is complete.
    prod_traffic_route: ?TrafficRoute,

    /// One pair of target groups. One is associated with the original task set. The
    /// second
    /// is associated with the task set that serves traffic after the deployment is
    /// complete.
    target_groups: ?[]const TargetGroupInfo,

    /// An optional path used by a load balancer to route test traffic after an
    /// Amazon ECS deployment. Validation can occur while test traffic is served
    /// during a
    /// deployment.
    test_traffic_route: ?TrafficRoute,

    pub const json_field_names = .{
        .prod_traffic_route = "prodTrafficRoute",
        .target_groups = "targetGroups",
        .test_traffic_route = "testTrafficRoute",
    };
};
