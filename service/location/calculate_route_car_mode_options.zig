/// Contains details about additional route preferences for requests that
/// specify `TravelMode` as `Car`.
pub const CalculateRouteCarModeOptions = struct {
    /// Avoids ferries when calculating routes.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    avoid_ferries: ?bool,

    /// Avoids tolls when calculating routes.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    avoid_tolls: ?bool,

    pub const json_field_names = .{
        .avoid_ferries = "AvoidFerries",
        .avoid_tolls = "AvoidTolls",
    };
};
