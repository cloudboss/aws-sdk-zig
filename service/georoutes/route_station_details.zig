const RouteAccessibilityAvailabilityDetails = @import("route_accessibility_availability_details.zig").RouteAccessibilityAvailabilityDetails;

/// Details about the station.
pub const RouteStationDetails = struct {
    /// Wheelchair accessibility information for the station.
    accessibility: ?RouteAccessibilityAvailabilityDetails = null,

    /// Platform name or number.
    platform_name: ?[]const u8 = null,

    /// Short text or a number that identifies the station.
    short_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .accessibility = "Accessibility",
        .platform_name = "PlatformName",
        .short_name = "ShortName",
    };
};
