/// Information includes the Amazon Web Services account ID where the current
/// document is shared and the
/// version shared with that account.
pub const AccountSharingInfo = struct {
    /// The Amazon Web Services account ID where the current document is shared.
    account_id: ?[]const u8,

    /// The version of the current document shared with the account.
    shared_document_version: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .shared_document_version = "SharedDocumentVersion",
    };
};
