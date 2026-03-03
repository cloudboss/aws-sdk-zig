const AnalysisComponent = @import("analysis_component.zig").AnalysisComponent;

/// Describes a load balancer target.
pub const AnalysisLoadBalancerTarget = struct {
    /// The IP address.
    address: ?[]const u8 = null,

    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// Information about the instance.
    instance: ?AnalysisComponent = null,

    /// The port on which the target is listening.
    port: ?i32 = null,
};
