const FindingDetailsErrorCode = @import("finding_details_error_code.zig").FindingDetailsErrorCode;

/// Details about an error encountered when trying to return vulnerability data
/// for a
/// finding.
pub const FindingDetailsError = struct {
    /// The error code.
    error_code: FindingDetailsErrorCode,

    /// The error message.
    error_message: []const u8,

    /// The finding ARN that returned an error.
    finding_arn: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .finding_arn = "findingArn",
    };
};
