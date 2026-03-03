const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The menu options for the interactions of an image.
pub const ImageMenuOption = struct {
    /// The availability status of the image menu. If the value of this property is
    /// set to `ENABLED`, dashboard readers can interact with the image menu.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
