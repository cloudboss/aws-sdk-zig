/// Provides details about an error in a core network policy.
pub const CoreNetworkPolicyError = struct {
    /// The error code associated with a core network policy error.
    error_code: []const u8,

    /// The message associated with a core network policy error code.
    message: []const u8,

    /// The JSON path where the error was discovered in the policy document.
    path: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
        .path = "Path",
    };
};
