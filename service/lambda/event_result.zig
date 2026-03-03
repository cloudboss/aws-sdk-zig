/// Result information for an event.
pub const EventResult = struct {
    /// The result payload.
    payload: ?[]const u8 = null,

    /// Indicates if the error payload was truncated due to size limits.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .payload = "Payload",
        .truncated = "Truncated",
    };
};
