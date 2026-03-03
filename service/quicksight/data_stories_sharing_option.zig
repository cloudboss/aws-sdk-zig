const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Executive summary option.
pub const DataStoriesSharingOption = struct {
    /// Availability status.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
