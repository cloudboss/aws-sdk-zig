const TimeBasedCanary = @import("time_based_canary.zig").TimeBasedCanary;
const TimeBasedLinear = @import("time_based_linear.zig").TimeBasedLinear;
const TrafficRoutingType = @import("traffic_routing_type.zig").TrafficRoutingType;

/// The configuration that specifies how traffic is shifted from one version of
/// a Lambda function to another version during an Lambda deployment,
/// or from one Amazon ECS task set to another during an Amazon ECS
/// deployment.
pub const TrafficRoutingConfig = struct {
    /// A configuration that shifts traffic from one version of a Lambda function
    /// or ECS task set to another in two increments. The original and target Lambda
    /// function versions or ECS task sets are specified in the deployment's AppSpec
    /// file.
    time_based_canary: ?TimeBasedCanary,

    /// A configuration that shifts traffic from one version of a Lambda function
    /// or Amazon ECS task set to another in equal increments, with an equal number
    /// of
    /// minutes between each increment. The original and target Lambda function
    /// versions or Amazon ECS task sets are specified in the deployment's AppSpec
    /// file.
    time_based_linear: ?TimeBasedLinear,

    /// The type of traffic shifting (`TimeBasedCanary` or
    /// `TimeBasedLinear`) used by a deployment configuration.
    type: ?TrafficRoutingType,

    pub const json_field_names = .{
        .time_based_canary = "timeBasedCanary",
        .time_based_linear = "timeBasedLinear",
        .type = "type",
    };
};
