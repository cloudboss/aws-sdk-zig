const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The data point menu options of a dashboard.
pub const DataPointMenuLabelOption = struct {
    /// The status of the data point menu options.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
