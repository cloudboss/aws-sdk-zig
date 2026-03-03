const ShareMethod = @import("share_method.zig").ShareMethod;
const ShareStatus = @import("share_status.zig").ShareStatus;

/// Details about the shared directory in the directory owner account for which
/// the share
/// request in the directory consumer account has been accepted.
pub const SharedDirectory = struct {
    /// The date and time that the shared directory was created.
    created_date_time: ?i64 = null,

    /// The date and time that the shared directory was last updated.
    last_updated_date_time: ?i64 = null,

    /// Identifier of the directory owner account, which contains the directory that
    /// has been
    /// shared to the consumer account.
    owner_account_id: ?[]const u8 = null,

    /// Identifier of the directory in the directory owner account.
    owner_directory_id: ?[]const u8 = null,

    /// Identifier of the directory consumer account that has access to the shared
    /// directory
    /// (`OwnerDirectoryId`) in the directory owner account.
    shared_account_id: ?[]const u8 = null,

    /// Identifier of the shared directory in the directory consumer account. This
    /// identifier is
    /// different for each directory owner account.
    shared_directory_id: ?[]const u8 = null,

    /// The method used when sharing a directory to determine whether the directory
    /// should be
    /// shared within your Amazon Web Services organization (`ORGANIZATIONS`) or
    /// with any Amazon Web Services account
    /// by sending a shared directory request (`HANDSHAKE`).
    share_method: ?ShareMethod = null,

    /// A directory share request that is sent by the directory owner to the
    /// directory consumer.
    /// The request includes a typed message to help the directory consumer
    /// administrator determine
    /// whether to approve or reject the share invitation.
    share_notes: ?[]const u8 = null,

    /// Current directory status of the shared Managed Microsoft AD directory.
    share_status: ?ShareStatus = null,

    pub const json_field_names = .{
        .created_date_time = "CreatedDateTime",
        .last_updated_date_time = "LastUpdatedDateTime",
        .owner_account_id = "OwnerAccountId",
        .owner_directory_id = "OwnerDirectoryId",
        .shared_account_id = "SharedAccountId",
        .shared_directory_id = "SharedDirectoryId",
        .share_method = "ShareMethod",
        .share_notes = "ShareNotes",
        .share_status = "ShareStatus",
    };
};
