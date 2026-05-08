const TrafficSplitEntry = @import("traffic_split_entry.zig").TrafficSplitEntry;

/// A weighted configuration bundle override that splits traffic between
/// multiple bundle versions.
pub const WeightedOverride = struct {
    /// The traffic split entries defining how traffic is distributed between
    /// configuration bundle versions.
    traffic_split: []const TrafficSplitEntry,

    pub const json_field_names = .{
        .traffic_split = "trafficSplit",
    };
};
