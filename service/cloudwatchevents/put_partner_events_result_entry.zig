/// Represents an event that a partner tried to generate, but failed.
pub const PutPartnerEventsResultEntry = struct {
    /// The error code that indicates why the event submission failed.
    error_code: ?[]const u8,

    /// The error message that explains why the event submission failed.
    error_message: ?[]const u8,

    /// The ID of the event.
    event_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .event_id = "EventId",
    };
};
