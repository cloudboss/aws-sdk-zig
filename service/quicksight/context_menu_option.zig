const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The context menu options for a visual's interactions.
pub const ContextMenuOption = struct {
    /// The availability status of the context menu options. If the value of this
    /// property is set to `ENABLED`, dashboard readers can interact with the
    /// context menu.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
