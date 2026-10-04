const RouteAccessibilityAttribute = @import("route_accessibility_attribute.zig").RouteAccessibilityAttribute;
const RouteTransitMode = @import("route_transit_mode.zig").RouteTransitMode;
const RouteTransitPedestrianOptions = @import("route_transit_pedestrian_options.zig").RouteTransitPedestrianOptions;

/// Options related to transit routing.
///
/// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
/// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
pub const RouteTransitOptions = struct {
    /// Accessibility attributes to consider when calculating the route.
    accessibility_attributes: ?[]const RouteAccessibilityAttribute = null,

    /// Allowed transit transport modes when calculating the route. By default, all
    /// transport modes are allowed. Cannot be used together with `ExcludedModes`.
    allowed_modes: ?[]const RouteTransitMode = null,

    /// Excluded transit transport modes when calculating the route. By default, all
    /// transport modes are allowed. Cannot be used together with `AllowedModes`.
    excluded_modes: ?[]const RouteTransitMode = null,

    /// Maximum number of transfers allowed when calculating the route.
    max_transfers: ?i32 = null,

    /// Options for the pedestrian leg of the transit route.
    pedestrian: ?RouteTransitPedestrianOptions = null,

    pub const json_field_names = .{
        .accessibility_attributes = "AccessibilityAttributes",
        .allowed_modes = "AllowedModes",
        .excluded_modes = "ExcludedModes",
        .max_transfers = "MaxTransfers",
        .pedestrian = "Pedestrian",
    };
};
