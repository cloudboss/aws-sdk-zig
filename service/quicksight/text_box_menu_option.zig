const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The menu options for the interactions of a textbox.
pub const TextBoxMenuOption = struct {
    /// The availability status of the textbox menu. If the value of this property
    /// is set to `ENABLED`, dashboard readers can interact with the textbox menu.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
