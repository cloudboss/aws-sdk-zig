const IncludeDetail = @import("include_detail.zig").IncludeDetail;
const Level = @import("level.zig").Level;

/// The logging configuration settings for the event bus.
///
/// For more information, see [Configuring logs for event
/// buses](https://docs.aws.amazon.com/eb-event-bus-logs.html) in the
/// *EventBridge User Guide*.
pub const LogConfig = struct {
    /// Whether EventBridge include detailed event information in the records it
    /// generates.
    /// Detailed data can be useful for troubleshooting and debugging. This
    /// information includes details of the event itself, as well as target details.
    ///
    /// For more information, see [Including detail data in event bus
    /// logs](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus-logs.html#eb-event-logs-data) in the *EventBridge User Guide*.
    include_detail: ?IncludeDetail,

    /// The level of logging detail to include. This applies to all log destinations
    /// for the event bus.
    ///
    /// For more information, see [Specifying event bus log
    /// level](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus-logs.html#eb-event-bus-logs-level) in the *EventBridge User Guide*.
    level: ?Level,

    pub const json_field_names = .{
        .include_detail = "IncludeDetail",
        .level = "Level",
    };
};
