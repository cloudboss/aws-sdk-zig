const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The drill down options for data points in a dashbaord.
pub const DataPointDrillUpDownOption = struct {
    /// The status of the drill down options of data points.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
