const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// An ad hoc (one-time) filtering option.
pub const AdHocFilteringOption = struct {
    /// Availability status.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
