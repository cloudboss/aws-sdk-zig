const RouteTaxiMode = @import("route_taxi_mode.zig").RouteTaxiMode;
const RouteIntermodalEnabledLegs = @import("route_intermodal_enabled_legs.zig").RouteIntermodalEnabledLegs;

/// Options for the taxi leg of the intermodal route.
pub const RouteIntermodalTaxiOptions = struct {
    /// Allowed taxi transport modes when calculating the route. By default, all
    /// transport modes are allowed. Cannot be used together with `ExcludedModes`.
    allowed_modes: ?[]const RouteTaxiMode = null,

    /// Specifies the portion of the route for which this leg type is enabled. By
    /// default, the leg type is enabled for all legs. Valid values:
    ///
    /// * `FirstLeg` - Enable this leg type for the first non-pedestrian leg of the
    ///   route.
    /// * `LastLeg` - Enable this leg type for the last non-pedestrian leg of the
    ///   route.
    /// * `EntireRoute` - Enable this leg type for the entire route.
    /// * `None` - Disable this leg type entirely.
    enabled_for: ?[]const RouteIntermodalEnabledLegs = null,

    /// Excluded taxi transport modes when calculating the route. By default, all
    /// transport modes are allowed. Cannot be used together with `AllowedModes`.
    excluded_modes: ?[]const RouteTaxiMode = null,

    pub const json_field_names = .{
        .allowed_modes = "AllowedModes",
        .enabled_for = "EnabledFor",
        .excluded_modes = "ExcludedModes",
    };
};
