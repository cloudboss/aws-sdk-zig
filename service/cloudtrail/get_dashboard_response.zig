const RefreshSchedule = @import("refresh_schedule.zig").RefreshSchedule;
const DashboardStatus = @import("dashboard_status.zig").DashboardStatus;
const DashboardType = @import("dashboard_type.zig").DashboardType;
const Widget = @import("widget.zig").Widget;

pub const GetDashboardResponse = struct {
    /// The timestamp that shows when the dashboard was created.
    created_timestamp: ?i64 = null,

    /// The ARN for the dashboard.
    dashboard_arn: ?[]const u8 = null,

    /// Provides information about failures for the last scheduled refresh.
    last_refresh_failure_reason: ?[]const u8 = null,

    /// The ID of the last dashboard refresh.
    last_refresh_id: ?[]const u8 = null,

    /// The refresh schedule for the dashboard, if configured.
    refresh_schedule: ?RefreshSchedule = null,

    /// The status of the dashboard.
    status: ?DashboardStatus = null,

    /// Indicates whether termination protection is enabled for the dashboard.
    termination_protection_enabled: ?bool = null,

    /// The type of dashboard.
    @"type": ?DashboardType = null,

    /// The timestamp that shows when the dashboard was last updated.
    updated_timestamp: ?i64 = null,

    /// An array of widgets for the dashboard.
    widgets: ?[]const Widget = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .dashboard_arn = "DashboardArn",
        .last_refresh_failure_reason = "LastRefreshFailureReason",
        .last_refresh_id = "LastRefreshId",
        .refresh_schedule = "RefreshSchedule",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .@"type" = "Type",
        .updated_timestamp = "UpdatedTimestamp",
        .widgets = "Widgets",
    };
};
