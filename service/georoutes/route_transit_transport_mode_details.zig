const RouteAccessibilityAvailabilityDetails = @import("route_accessibility_availability_details.zig").RouteAccessibilityAvailabilityDetails;
const RouteTransitMode = @import("route_transit_mode.zig").RouteTransitMode;

/// Transport mode details for the transit leg.
pub const RouteTransitTransportModeDetails = struct {
    /// Wheelchair accessibility information for the transit vehicle.
    accessibility: ?RouteAccessibilityAvailabilityDetails = null,

    /// Color of the transport polyline and background for the transport name.
    color: ?[]const u8 = null,

    /// Transit route headsign.
    headsign: ?[]const u8 = null,

    /// Long name of the transit route.
    long_route_name: ?[]const u8 = null,

    /// Mode of the transit transport.
    mode: RouteTransitMode,

    /// Transit route name.
    route_name: ?[]const u8 = null,

    /// Short name of the transit route.
    short_route_name: ?[]const u8 = null,

    /// Color of the transport name text.
    text_color: ?[]const u8 = null,

    pub const json_field_names = .{
        .accessibility = "Accessibility",
        .color = "Color",
        .headsign = "Headsign",
        .long_route_name = "LongRouteName",
        .mode = "Mode",
        .route_name = "RouteName",
        .short_route_name = "ShortRouteName",
        .text_color = "TextColor",
    };
};
