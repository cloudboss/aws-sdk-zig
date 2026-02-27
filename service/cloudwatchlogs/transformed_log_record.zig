/// This structure contains information for one log event that has been
/// processed by a log
/// transformer.
pub const TransformedLogRecord = struct {
    /// The original log event message before it was transformed.
    event_message: ?[]const u8,

    /// The event number.
    event_number: i64 = 0,

    /// The log event message after being transformed.
    transformed_event_message: ?[]const u8,

    pub const json_field_names = .{
        .event_message = "eventMessage",
        .event_number = "eventNumber",
        .transformed_event_message = "transformedEventMessage",
    };
};
