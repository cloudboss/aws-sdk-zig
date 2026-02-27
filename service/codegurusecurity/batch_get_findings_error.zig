const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains information about the error that caused a finding to fail to be
/// retrieved.
pub const BatchGetFindingsError = struct {
    /// A code associated with the type of error.
    error_code: ErrorCode,

    /// The finding ID of the finding that was not fetched.
    finding_id: []const u8,

    /// Describes the error.
    message: []const u8,

    /// The name of the scan that generated the finding.
    scan_name: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .finding_id = "findingId",
        .message = "message",
        .scan_name = "scanName",
    };
};
