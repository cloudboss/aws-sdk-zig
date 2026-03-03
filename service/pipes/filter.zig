/// Filter events using an event pattern. For more information, see [Events and
/// Event
/// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *Amazon EventBridge User Guide*.
pub const Filter = struct {
    /// The event pattern.
    pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .pattern = "Pattern",
    };
};
