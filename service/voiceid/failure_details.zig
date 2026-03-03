/// Contains error details for a failed batch job.
pub const FailureDetails = struct {
    /// A description of the error that caused the batch job failure.
    message: ?[]const u8 = null,

    /// An HTTP status code representing the nature of the error.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
