const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Determines if hidden fields are included in an exported dashboard.
pub const ExportHiddenFieldsOption = struct {
    /// The status of the export hidden fields options of a dashbaord.
    availability_status: ?DashboardBehavior = null,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
