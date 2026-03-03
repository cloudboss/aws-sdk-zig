const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Export to .csv option.
pub const ExportToCSVOption = struct {
    /// Availability status.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
