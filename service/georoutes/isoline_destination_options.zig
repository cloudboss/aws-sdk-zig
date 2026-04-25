const IsolineMatchingOptions = @import("isoline_matching_options.zig").IsolineMatchingOptions;
const IsolineSideOfStreetOptions = @import("isoline_side_of_street_options.zig").IsolineSideOfStreetOptions;

/// Options that control how the destination point is interpreted and matched to
/// the road network when calculating reachable areas. This affects which roads
/// are considered accessible near the destination and how the final approach is
/// calculated.
pub const IsolineDestinationOptions = struct {
    /// The distance in meters from the destination point within which certain
    /// routing actions (such as U-turns or left turns across traffic) are
    /// restricted. This helps generate more practical routes by avoiding
    /// potentially dangerous maneuvers near the endpoint.
    avoid_actions_for_distance: i64 = 0,

    /// The initial direction of travel in degrees (0-360, where 0 is north). This
    /// can affect which road segments are considered accessible from the starting
    /// point.
    heading: f64 = 0,

    /// Controls how the destination point is matched to the road network, including
    /// search radius and name-based matching preferences.
    matching: ?IsolineMatchingOptions = null,

    /// Specifies which side of the street should be considered accessible, which is
    /// important when building entrances or parking access points are only
    /// reachable from one side of the road.
    side_of_street: ?IsolineSideOfStreetOptions = null,

    pub const json_field_names = .{
        .avoid_actions_for_distance = "AvoidActionsForDistance",
        .heading = "Heading",
        .matching = "Matching",
        .side_of_street = "SideOfStreet",
    };
};
