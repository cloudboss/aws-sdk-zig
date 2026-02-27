const MatchingStrategy = @import("matching_strategy.zig").MatchingStrategy;

/// Matching options.
pub const RouteMatrixMatchingOptions = struct {
    /// Attempts to match the provided position to a road similar to the provided
    /// name.
    name_hint: ?[]const u8,

    /// If the distance to a highway/bridge/tunnel/sliproad is within threshold, the
    /// waypoint will be snapped to the highway/bridge/tunnel/sliproad.
    ///
    /// **Unit**: `meters`
    on_road_threshold: i64 = 0,

    /// Considers all roads within the provided radius to match the provided
    /// destination to. The roads that are considered are determined by the provided
    /// Strategy.
    ///
    /// **Unit**: `Meters`
    radius: i64 = 0,

    /// Strategy that defines matching of the position onto the road network.
    /// MatchAny considers all roads possible, whereas MatchMostSignificantRoad
    /// matches to the most significant road.
    strategy: ?MatchingStrategy,

    pub const json_field_names = .{
        .name_hint = "NameHint",
        .on_road_threshold = "OnRoadThreshold",
        .radius = "Radius",
        .strategy = "Strategy",
    };
};
