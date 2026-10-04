const RouteAccessibilityAvailabilityDetails = @import("route_accessibility_availability_details.zig").RouteAccessibilityAvailabilityDetails;

/// Details of the access point.
pub const RouteAccessPointDetails = struct {
    /// Wheelchair accessibility information for the access point.
    accessibility: ?RouteAccessibilityAvailabilityDetails = null,

    pub const json_field_names = .{
        .accessibility = "Accessibility",
    };
};
