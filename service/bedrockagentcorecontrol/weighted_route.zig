const TargetTrafficSplitEntry = @import("target_traffic_split_entry.zig").TargetTrafficSplitEntry;

/// A weighted route that splits traffic between multiple gateway targets.
pub const WeightedRoute = struct {
    /// The traffic split entries defining how traffic is distributed between
    /// targets.
    traffic_split: []const TargetTrafficSplitEntry,

    pub const json_field_names = .{
        .traffic_split = "trafficSplit",
    };
};
