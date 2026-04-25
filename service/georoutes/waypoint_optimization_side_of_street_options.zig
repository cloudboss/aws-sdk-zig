const SideOfStreetMatchingStrategy = @import("side_of_street_matching_strategy.zig").SideOfStreetMatchingStrategy;

/// Options to configure matching the provided position to a side of the street.
pub const WaypointOptimizationSideOfStreetOptions = struct {
    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Strategy that defines when the side of street position should be used.
    /// AnyStreet will always use the provided position.
    ///
    /// Default value: `DividedStreetOnly`
    use_with: ?SideOfStreetMatchingStrategy = null,

    pub const json_field_names = .{
        .position = "Position",
        .use_with = "UseWith",
    };
};
