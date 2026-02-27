const ShareError = @import("share_error.zig").ShareError;

/// Information about the portfolio share operation.
pub const ShareDetails = struct {
    /// List of errors.
    share_errors: ?[]const ShareError,

    /// List of accounts for whom the operation succeeded.
    successful_shares: ?[]const []const u8,

    pub const json_field_names = .{
        .share_errors = "ShareErrors",
        .successful_shares = "SuccessfulShares",
    };
};
