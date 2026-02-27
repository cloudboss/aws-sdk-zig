const LogLevel = @import("log_level.zig").LogLevel;

/// Configuration for event-based logging that specifies which event types to
/// log and their logging settings. Used for account-level logging overrides.
pub const LogEventConfiguration = struct {
    /// The type of event to log. These include event types like Connect, Publish,
    /// and Disconnect.
    event_type: []const u8,

    /// CloudWatch Log Group for event-based logging. Specifies where log events
    /// should be sent. The log destination for event-based logging overrides
    /// default Log Group for the specified event type and applies to all resources
    /// associated with that event.
    log_destination: ?[]const u8,

    /// The logging level for the specified event type. Determines the verbosity of
    /// log messages generated for this event type.
    log_level: ?LogLevel,

    pub const json_field_names = .{
        .event_type = "eventType",
        .log_destination = "logDestination",
        .log_level = "logLevel",
    };
};
