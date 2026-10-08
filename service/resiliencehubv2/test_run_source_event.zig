const TestRunSourceEventDetail = @import("test_run_source_event_detail.zig").TestRunSourceEventDetail;
const TestRunSourceEventType = @import("test_run_source_event_type.zig").TestRunSourceEventType;

/// A state-change event observed for a test run monitoring source.
pub const TestRunSourceEvent = struct {
    /// The event payload.
    detail: TestRunSourceEventDetail,

    /// The type of the event. ALARM indicates an event from a CloudWatch alarm
    /// source; the detail member carries either the alarm state change or a
    /// collection error.
    event_type: TestRunSourceEventType,

    /// The ARN of the monitoring source the event belongs to.
    source_arn: []const u8,

    /// The timestamp when the event occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .detail = "detail",
        .event_type = "eventType",
        .source_arn = "sourceArn",
        .timestamp = "timestamp",
    };
};
