const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Data stories sharing option.
pub const ExecutiveSummaryOption = struct {
    /// Availability status.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
