/// Errors that occurred during the portfolio share operation.
pub const ShareError = struct {
    /// List of accounts impacted by the error.
    accounts: ?[]const []const u8,

    /// Error type that happened when processing the operation.
    @"error": ?[]const u8,

    /// Information about the error.
    message: ?[]const u8,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .@"error" = "Error",
        .message = "Message",
    };
};
