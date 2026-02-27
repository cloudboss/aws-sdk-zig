const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// The sheet layout maximization options of a dashbaord.
pub const SheetLayoutElementMaximizationOption = struct {
    /// The status of the sheet layout maximization options of a dashbaord.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
