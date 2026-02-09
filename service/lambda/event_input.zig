/// Input information for an event.
pub const EventInput = struct {
    /// The input payload.
    payload: ?[]const u8,

    /// Indicates if the error payload was truncated due to size limits.
    truncated: ?bool,
};
