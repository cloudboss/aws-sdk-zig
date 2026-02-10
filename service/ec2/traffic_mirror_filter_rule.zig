const TrafficMirrorPortRange = @import("traffic_mirror_port_range.zig").TrafficMirrorPortRange;
const TrafficMirrorRuleAction = @import("traffic_mirror_rule_action.zig").TrafficMirrorRuleAction;
const Tag = @import("tag.zig").Tag;
const TrafficDirection = @import("traffic_direction.zig").TrafficDirection;

/// Describes the Traffic Mirror rule.
pub const TrafficMirrorFilterRule = struct {
    /// The description of the Traffic Mirror rule.
    description: ?[]const u8,

    /// The destination CIDR block assigned to the Traffic Mirror rule.
    destination_cidr_block: ?[]const u8,

    /// The destination port range assigned to the Traffic Mirror rule.
    destination_port_range: ?TrafficMirrorPortRange,

    /// The protocol assigned to the Traffic Mirror rule.
    protocol: ?i32,

    /// The action assigned to the Traffic Mirror rule.
    rule_action: ?TrafficMirrorRuleAction,

    /// The rule number of the Traffic Mirror rule.
    rule_number: ?i32,

    /// The source CIDR block assigned to the Traffic Mirror rule.
    source_cidr_block: ?[]const u8,

    /// The source port range assigned to the Traffic Mirror rule.
    source_port_range: ?TrafficMirrorPortRange,

    /// Tags on Traffic Mirroring filter rules.
    tags: ?[]const Tag,

    /// The traffic direction assigned to the Traffic Mirror rule.
    traffic_direction: ?TrafficDirection,

    /// The ID of the Traffic Mirror filter that the rule is associated with.
    traffic_mirror_filter_id: ?[]const u8,

    /// The ID of the Traffic Mirror rule.
    traffic_mirror_filter_rule_id: ?[]const u8,
};
