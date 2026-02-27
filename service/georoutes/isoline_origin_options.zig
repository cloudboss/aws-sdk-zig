const IsolineMatchingOptions = @import("isoline_matching_options.zig").IsolineMatchingOptions;
const IsolineSideOfStreetOptions = @import("isoline_side_of_street_options.zig").IsolineSideOfStreetOptions;

/// Origin related options.
pub const IsolineOriginOptions = struct {
    /// Avoids actions for the provided distance. This is typically to consider for
    /// users in moving vehicles who may not have sufficient time to make an action
    /// at an origin or a destination.
    avoid_actions_for_distance: i64 = 0,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// Options to configure matching the provided position to the road network.
    matching: ?IsolineMatchingOptions,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?IsolineSideOfStreetOptions,

    pub const json_field_names = .{
        .avoid_actions_for_distance = "AvoidActionsForDistance",
        .heading = "Heading",
        .matching = "Matching",
        .side_of_street = "SideOfStreet",
    };
};
