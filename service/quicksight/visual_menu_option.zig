const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The menu options for a visual.
pub const VisualMenuOption = struct {
    /// The availaiblity status of a visual's menu options.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
