/// A structure that contains Evidently's response to the sent events, including
/// an event ID and error codes, if any.
pub const PutProjectEventsResultEntry = struct {
    /// If the `PutProjectEvents` operation has an error, the error code is returned
    /// here.
    error_code: ?[]const u8 = null,

    /// If the `PutProjectEvents` operation has an error, the error message is
    /// returned here.
    error_message: ?[]const u8 = null,

    /// A unique ID assigned to this `PutProjectEvents` operation.
    event_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .event_id = "eventId",
    };
};
