const BatchReadException = @import("batch_read_exception.zig").BatchReadException;
const BatchReadSuccessfulResponse = @import("batch_read_successful_response.zig").BatchReadSuccessfulResponse;

/// Represents the output of a `BatchRead` response operation.
pub const BatchReadOperationResponse = struct {
    /// Identifies which operation in a batch has failed.
    exception_response: ?BatchReadException,

    /// Identifies which operation in a batch has succeeded.
    successful_response: ?BatchReadSuccessfulResponse,

    pub const json_field_names = .{
        .exception_response = "ExceptionResponse",
        .successful_response = "SuccessfulResponse",
    };
};
