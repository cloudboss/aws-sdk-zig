const MatchingStrategy = @import("matching_strategy.zig").MatchingStrategy;

/// Controls how origin and destination points are matched to the road network
/// when they don't fall exactly on a road. Matching options help ensure
/// realistic routing by connecting points to appropriate roads.
pub const IsolineMatchingOptions = struct {
    /// The expected street name near the point. Helps disambiguate matching when
    /// multiple roads are within range.
    name_hint: ?[]const u8 = null,

    /// The maximum distance in meters that a point can be from a road while still
    /// being considered "on" that road. Points further than this distance require
    /// explicit matching.
    ///
    /// **Unit**: `meters`
    on_road_threshold: i64 = 0,

    /// The maximum distance in meters to search for roads to match to. Points with
    /// no roads within this radius will fail to match. The roads that are
    /// considered within this radius are determined by the specified `Strategy`
    ///
    /// **Unit**: `meters`
    radius: i64 = 0,

    /// Determines how points are matched to the road network. `MatchAny` finds the
    /// nearest viable road segment, while `MatchMostSignificantRoad` prioritizes
    /// major roads.
    strategy: ?MatchingStrategy = null,

    pub const json_field_names = .{
        .name_hint = "NameHint",
        .on_road_threshold = "OnRoadThreshold",
        .radius = "Radius",
        .strategy = "Strategy",
    };
};
