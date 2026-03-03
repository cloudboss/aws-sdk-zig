const TruckDimensions = @import("truck_dimensions.zig").TruckDimensions;
const TruckWeight = @import("truck_weight.zig").TruckWeight;

/// Contains details about additional route preferences for requests that
/// specify `TravelMode` as `Truck`.
pub const CalculateRouteTruckModeOptions = struct {
    /// Avoids ferries when calculating routes.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    avoid_ferries: ?bool = null,

    /// Avoids tolls when calculating routes.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    avoid_tolls: ?bool = null,

    /// Specifies the truck's dimension specifications including length, height,
    /// width, and unit of measurement. Used to avoid roads that can't support the
    /// truck's dimensions.
    dimensions: ?TruckDimensions = null,

    /// Specifies the truck's weight specifications including total weight and unit
    /// of measurement. Used to avoid roads that can't support the truck's weight.
    weight: ?TruckWeight = null,

    pub const json_field_names = .{
        .avoid_ferries = "AvoidFerries",
        .avoid_tolls = "AvoidTolls",
        .dimensions = "Dimensions",
        .weight = "Weight",
    };
};
