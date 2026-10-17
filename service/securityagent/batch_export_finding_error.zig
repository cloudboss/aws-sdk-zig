const ErrorCode = @import("error_code.zig").ErrorCode;

/// A finding whose issue could not be created, with the cause of the failure.
pub const BatchExportFindingError = struct {
    /// The machine-readable failure category.
    code: ErrorCode,

    /// The identifier of the finding this error corresponds to.
    finding_id: []const u8,

    /// A customer-facing explanation of why the issue could not be created.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .finding_id = "findingId",
        .message = "message",
    };
};
