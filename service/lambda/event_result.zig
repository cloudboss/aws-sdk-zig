/// Result information for an event.
pub const EventResult = struct {
    /// The result payload.
    payload: ?[]const u8,

    /// Indicates if the error payload was truncated due to size limits.
    truncated: ?bool,

    pub const json_field_names = .{
        .payload = "Payload",
        .truncated = "Truncated",
    };
};
