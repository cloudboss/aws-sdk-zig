/// Contains information about an error that occurred for a specific security
/// requirement during a batch operation.
pub const BatchSecurityRequirementError = struct {
    /// The error code.
    code: []const u8,

    /// The error message.
    message: []const u8,

    /// The name of the security requirement that caused the error.
    security_requirement_name: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .security_requirement_name = "securityRequirementName",
    };
};
