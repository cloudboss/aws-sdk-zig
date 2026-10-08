const AlarmStateChangeDetail = @import("alarm_state_change_detail.zig").AlarmStateChangeDetail;
const TestRunSourceEventError = @import("test_run_source_event_error.zig").TestRunSourceEventError;

/// The payload of a test run source event. Exactly one member is set.
pub const TestRunSourceEventDetail = union(enum) {
    /// A CloudWatch alarm state change.
    alarm_state_change: ?AlarmStateChangeDetail,
    /// An error that prevented event collection from the source.
    @"error": ?TestRunSourceEventError,

    pub const json_field_names = .{
        .alarm_state_change = "alarmStateChange",
        .@"error" = "error",
    };
};
