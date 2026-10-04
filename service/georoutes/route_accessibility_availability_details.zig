const RouteAccessibilityAvailability = @import("route_accessibility_availability.zig").RouteAccessibilityAvailability;

/// Details about the availability of accessibility features.
pub const RouteAccessibilityAvailabilityDetails = struct {
    /// Wheelchair accessibility status.
    wheelchair: ?RouteAccessibilityAvailability = null,

    pub const json_field_names = .{
        .wheelchair = "Wheelchair",
    };
};
