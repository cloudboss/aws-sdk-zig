/// Error details for the failed asynchronous operation.
pub const AsyncErrorDetails = struct {
    /// A string that uniquely identifies the error condition.
    code: ?[]const u8 = null,

    /// A generic description of the error condition in English.
    message: ?[]const u8 = null,

    /// The ID of the request associated with the error.
    request_id: ?[]const u8 = null,

    /// The identifier of the resource associated with the error.
    resource: ?[]const u8 = null,
};
