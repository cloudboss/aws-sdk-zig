const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Determines if Actions in Amazon Quick Suite are enabled in a dashboard..
pub const QuickSuiteActionsOption = struct {
    /// Availability status.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
