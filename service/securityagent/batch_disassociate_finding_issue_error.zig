const ErrorCode = @import("error_code.zig").ErrorCode;

/// A finding that failed to disassociate, with the cause of the failure.
pub const BatchDisassociateFindingIssueError = struct {
    /// The machine-readable failure category.
    code: ErrorCode,

    /// The identifier of the finding that failed to disassociate.
    finding_id: []const u8,

    /// A customer-facing explanation of the failure.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .finding_id = "findingId",
        .message = "message",
    };
};
