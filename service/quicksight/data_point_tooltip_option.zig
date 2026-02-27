const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The data point tooltip options.
pub const DataPointTooltipOption = struct {
    /// The status of the data point tool tip options.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
