const IsolineMatchingOptions = @import("isoline_matching_options.zig").IsolineMatchingOptions;
const IsolineSideOfStreetOptions = @import("isoline_side_of_street_options.zig").IsolineSideOfStreetOptions;

/// Options that control how the origin point is interpreted when calculating
/// reachable areas. These options affect which roads are considered accessible
/// from the starting point and how initial routing decisions are made.
pub const IsolineOriginOptions = struct {
    /// The distance in meters from the origin point within which certain routing
    /// actions (such as U-turns or left turns across traffic) are restricted. This
    /// helps generate more practical routes by avoiding potentially dangerous
    /// maneuvers near the starting point.
    avoid_actions_for_distance: i64 = 0,

    /// Initial direction of travel in degrees (0-360, where 0 is north). This
    /// affects which road segments are considered accessible from the starting
    /// point and is particularly useful when the origin is on a divided road or at
    /// a complex intersection.
    heading: f64 = 0,

    /// Controls how the origin point is matched to the road network, including
    /// search radius and matching strategy.
    matching: ?IsolineMatchingOptions = null,

    /// Controls which side of the street is considered accessible from the origin
    /// point, particularly important for divided roads where building entrances or
    /// parking access may only be available from one direction.
    side_of_street: ?IsolineSideOfStreetOptions = null,

    pub const json_field_names = .{
        .avoid_actions_for_distance = "AvoidActionsForDistance",
        .heading = "Heading",
        .matching = "Matching",
        .side_of_street = "SideOfStreet",
    };
};
