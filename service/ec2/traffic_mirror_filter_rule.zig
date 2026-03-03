const TrafficMirrorPortRange = @import("traffic_mirror_port_range.zig").TrafficMirrorPortRange;
const TrafficMirrorRuleAction = @import("traffic_mirror_rule_action.zig").TrafficMirrorRuleAction;
const Tag = @import("tag.zig").Tag;
const TrafficDirection = @import("traffic_direction.zig").TrafficDirection;

/// Describes the Traffic Mirror rule.
pub const TrafficMirrorFilterRule = struct {
    /// The description of the Traffic Mirror rule.
    description: ?[]const u8 = null,

    /// The destination CIDR block assigned to the Traffic Mirror rule.
    destination_cidr_block: ?[]const u8 = null,

    /// The destination port range assigned to the Traffic Mirror rule.
    destination_port_range: ?TrafficMirrorPortRange = null,

    /// The protocol assigned to the Traffic Mirror rule.
    protocol: ?i32 = null,

    /// The action assigned to the Traffic Mirror rule.
    rule_action: ?TrafficMirrorRuleAction = null,

    /// The rule number of the Traffic Mirror rule.
    rule_number: ?i32 = null,

    /// The source CIDR block assigned to the Traffic Mirror rule.
    source_cidr_block: ?[]const u8 = null,

    /// The source port range assigned to the Traffic Mirror rule.
    source_port_range: ?TrafficMirrorPortRange = null,

    /// Tags on Traffic Mirroring filter rules.
    tags: ?[]const Tag = null,

    /// The traffic direction assigned to the Traffic Mirror rule.
    traffic_direction: ?TrafficDirection = null,

    /// The ID of the Traffic Mirror filter that the rule is associated with.
    traffic_mirror_filter_id: ?[]const u8 = null,

    /// The ID of the Traffic Mirror rule.
    traffic_mirror_filter_rule_id: ?[]const u8 = null,
};
