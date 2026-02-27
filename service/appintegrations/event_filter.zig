/// The event filter.
pub const EventFilter = struct {
    /// The source of the events.
    source: []const u8,

    pub const json_field_names = .{
        .source = "Source",
    };
};
