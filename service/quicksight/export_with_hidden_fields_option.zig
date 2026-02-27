const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Determines whether or not hidden fields are visible on exported dashbaords.
pub const ExportWithHiddenFieldsOption = struct {
    /// The status of the export with hidden fields options.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
