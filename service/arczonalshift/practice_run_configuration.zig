const ControlCondition = @import("control_condition.zig").ControlCondition;

/// A practice run configuration for a resource includes the Amazon CloudWatch
/// alarms that you've specified for a practice run, as well as any blocked
/// dates or blocked windows for the practice run. When a resource has a
/// practice run configuration, ARC shifts traffic for the resource weekly for
/// practice runs.
///
/// Practice runs are required for zonal autoshift. The zonal shifts that ARC
/// starts for practice runs help you to ensure that shifting away traffic from
/// an Availability Zone during an autoshift is safe for your application.
///
/// You can update or delete a practice run configuration. Before you delete a
/// practice run configuration, you must disable zonal autoshift for the
/// resource. A practice run configuration is required when zonal autoshift is
/// enabled.
pub const PracticeRunConfiguration = struct {
    /// An array of one or more windows of days and times that you can allow ARC to
    /// start practice runs for a resource.
    ///
    /// For example, say you want to allow practice runs only on Wednesdays and
    /// Fridays from noon to 5 p.m. For this scenario, you could set the following
    /// recurring days and times as allowed windows, for example:
    /// `Wed-12:00-Wed:17:00 Fri-12:00-Fri:17:00`.
    ///
    /// The `allowedWindows` have to start and end on the same day. Windows that
    /// span multiple days aren't supported.
    allowed_windows: ?[]const []const u8,

    /// An array of one or more dates that you can specify when Amazon Web Services
    /// does not start practice runs for a resource.
    ///
    /// Specify blocked dates, in UTC, in the format `YYYY-MM-DD`, separated by
    /// spaces.
    blocked_dates: []const []const u8 = &.{},

    /// An array of one or more windows of days and times that you can block ARC
    /// from starting practice runs for a resource.
    ///
    /// Specify the blocked windows in UTC, using the format `DAY:HH:MM-DAY:HH:MM`,
    /// separated by spaces. For example, `MON:18:30-MON:19:30 TUE:18:30-TUE:19:30`.
    ///
    /// The `blockedWindows` have to start and end on the same day. Windows that
    /// span multiple days aren't supported.
    blocked_windows: ?[]const []const u8,

    /// *Blocking alarms* for practice runs are optional alarms that you can specify
    /// that block practice runs when one or more of the alarms is in an `ALARM`
    /// state.
    blocking_alarms: ?[]const ControlCondition,

    /// *Outcome alarms* for practice runs are alarms that you specify that end a
    /// practice run when one or more of the alarms is in an `ALARM` state.
    outcome_alarms: []const ControlCondition,

    pub const json_field_names = .{
        .allowed_windows = "allowedWindows",
        .blocked_dates = "blockedDates",
        .blocked_windows = "blockedWindows",
        .blocking_alarms = "blockingAlarms",
        .outcome_alarms = "outcomeAlarms",
    };
};
