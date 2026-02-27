/// A member account that was included in a request but for which the request
/// could not be
/// processed.
pub const UnprocessedAccount = struct {
    /// The Amazon Web Services account identifier of the member account that was
    /// not
    /// processed.
    account_id: ?[]const u8,

    /// The reason that the member account request could not be processed.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .reason = "Reason",
    };
};
