const SideOfStreetMatchingStrategy = @import("side_of_street_matching_strategy.zig").SideOfStreetMatchingStrategy;

/// Controls how points are matched to specific sides of streets. This is
/// important when the side of the street matters for accessibility - for
/// example, when building entrances or parking lot access points can only be
/// reached from one side of a divided road.
pub const IsolineSideOfStreetOptions = struct {
    /// The `[longitude, latitude]` coordinates of the point that should be matched
    /// to a specific side of the street.
    position: []const f64,

    /// Controls whether side-of-street matching is applied to any street
    /// (`AnyStreet`) or only to divided roads (`DividedStreetOnly`). This is
    /// important when the exact side of the street matters - for example, if a
    /// building entrance is only accessible from one side of a divided highway, or
    /// if a parking lot can only be entered from northbound lanes. Without correct
    /// side-of-street matching, travel time estimates may be inaccurate because
    /// they don't account for necessary U-turns or detours to reach the correct
    /// side.
    ///
    /// Default value: `DividedStreetOnly`
    use_with: ?SideOfStreetMatchingStrategy = null,

    pub const json_field_names = .{
        .position = "Position",
        .use_with = "UseWith",
    };
};
