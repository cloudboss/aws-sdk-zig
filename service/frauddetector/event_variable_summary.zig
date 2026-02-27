/// Information about the summary of an event variable that was evaluated for
/// generating prediction.
pub const EventVariableSummary = struct {
    /// The event variable name.
    name: ?[]const u8,

    /// The event variable source.
    source: ?[]const u8,

    /// The value of the event variable.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .source = "source",
        .value = "value",
    };
};
