/// Includes the error code and error message for events that could not be
/// ingested by CloudTrail.
pub const ResultErrorEntry = struct {
    /// The error code for events that could not be ingested by CloudTrail. Possible
    /// error codes include: `FieldTooLong`, `FieldNotFound`,
    /// `InvalidChecksum`, `InvalidData`, `InvalidRecipient`, `InvalidEventSource`,
    /// `AccountNotSubscribed`,
    /// `Throttling`, and `InternalFailure`.
    error_code: []const u8,

    /// The message that describes the error for events that could not be ingested
    /// by CloudTrail.
    error_message: []const u8,

    /// The original event ID from the source event that could not be ingested by
    /// CloudTrail.
    id: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
    };
};
