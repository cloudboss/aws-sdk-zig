const AnalysisComponent = @import("analysis_component.zig").AnalysisComponent;

/// Describes a load balancer target.
pub const AnalysisLoadBalancerTarget = struct {
    /// The IP address.
    address: ?[]const u8,

    /// The Availability Zone.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8,

    /// Information about the instance.
    instance: ?AnalysisComponent,

    /// The port on which the target is listening.
    port: ?i32,
};
