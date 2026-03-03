const TrafficMirrorFilterRule = @import("traffic_mirror_filter_rule.zig").TrafficMirrorFilterRule;
const TrafficMirrorNetworkService = @import("traffic_mirror_network_service.zig").TrafficMirrorNetworkService;
const Tag = @import("tag.zig").Tag;

/// Describes the Traffic Mirror filter.
pub const TrafficMirrorFilter = struct {
    /// The description of the Traffic Mirror filter.
    description: ?[]const u8 = null,

    /// Information about the egress rules that are associated with the Traffic
    /// Mirror filter.
    egress_filter_rules: ?[]const TrafficMirrorFilterRule = null,

    /// Information about the ingress rules that are associated with the Traffic
    /// Mirror filter.
    ingress_filter_rules: ?[]const TrafficMirrorFilterRule = null,

    /// The network service traffic that is associated with the Traffic Mirror
    /// filter.
    network_services: ?[]const TrafficMirrorNetworkService = null,

    /// The tags assigned to the Traffic Mirror filter.
    tags: ?[]const Tag = null,

    /// The ID of the Traffic Mirror filter.
    traffic_mirror_filter_id: ?[]const u8 = null,
};
