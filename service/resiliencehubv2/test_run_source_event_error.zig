const TestRunSourceEventErrorCode = @import("test_run_source_event_error_code.zig").TestRunSourceEventErrorCode;

/// Describes an error that prevented event collection from a test run
/// monitoring source.
pub const TestRunSourceEventError = struct {
    /// The error code.
    error_code: TestRunSourceEventErrorCode,

    /// A human-readable description of the error.
    error_message: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
