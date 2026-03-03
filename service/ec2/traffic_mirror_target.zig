const Tag = @import("tag.zig").Tag;
const TrafficMirrorTargetType = @import("traffic_mirror_target_type.zig").TrafficMirrorTargetType;

/// Describes a Traffic Mirror target.
pub const TrafficMirrorTarget = struct {
    /// Information about the Traffic Mirror target.
    description: ?[]const u8 = null,

    /// The ID of the Gateway Load Balancer endpoint.
    gateway_load_balancer_endpoint_id: ?[]const u8 = null,

    /// The network interface ID that is attached to the target.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Network Load Balancer.
    network_load_balancer_arn: ?[]const u8 = null,

    /// The ID of the account that owns the Traffic Mirror target.
    owner_id: ?[]const u8 = null,

    /// The tags assigned to the Traffic Mirror target.
    tags: ?[]const Tag = null,

    /// The ID of the Traffic Mirror target.
    traffic_mirror_target_id: ?[]const u8 = null,

    /// The type of Traffic Mirror target.
    @"type": ?TrafficMirrorTargetType = null,
};
