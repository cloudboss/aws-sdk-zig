const SideOfStreetMatchingStrategy = @import("side_of_street_matching_strategy.zig").SideOfStreetMatchingStrategy;

/// Options to configure matching the provided position to a side of the street.
pub const RouteMatrixSideOfStreetOptions = struct {
    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    /// Strategy that defines when the side of street position should be used.
    /// AnyStreet will always use the provided position.
    ///
    /// Default Value: `DividedStreetOnly`
    use_with: ?SideOfStreetMatchingStrategy = null,

    pub const json_field_names = .{
        .position = "Position",
        .use_with = "UseWith",
    };
};
