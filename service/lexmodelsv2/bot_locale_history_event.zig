/// Provides information about an event that occurred affecting the bot
/// locale.
pub const BotLocaleHistoryEvent = struct {
    /// A description of the event that occurred.
    event: []const u8,

    /// A timestamp of the date and time that the event occurred.
    event_date: i64,

    pub const json_field_names = .{
        .event = "event",
        .event_date = "eventDate",
    };
};
