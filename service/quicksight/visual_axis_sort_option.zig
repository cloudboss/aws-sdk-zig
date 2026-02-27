const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The axis sort options for a visual.
pub const VisualAxisSortOption = struct {
    /// The availaiblity status of a visual's axis sort options.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
