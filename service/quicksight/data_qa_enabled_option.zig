const DashboardBehavior = @import("dashboard_behavior.zig").DashboardBehavior;

/// Adds Q&A capabilities to a dashboard. If no topic is linked, Dashboard Q&A
/// uses the data values that are rendered on the dashboard. End users can use
/// Dashboard Q&A to ask for different slices of the data that they see on the
/// dashboard. If a topic is linked, Topic Q&A is enabled.
pub const DataQAEnabledOption = struct {
    /// The status of the Data Q&A option on the dashboard.
    availability_status: ?DashboardBehavior,

    pub const json_field_names = .{
        .availability_status = "AvailabilityStatus",
    };
};
