const AccountLinkStatusEnum = @import("account_link_status_enum.zig").AccountLinkStatusEnum;

/// Information about about the account link.
pub const AccountLink = struct {
    /// The identifier of the account link.
    account_link_id: ?[]const u8,

    /// The status of the account link.
    account_link_status: ?AccountLinkStatusEnum,

    /// The identifier of the source account.
    source_account_id: ?[]const u8,

    /// The identifier of the target account.
    target_account_id: ?[]const u8,

    pub const json_field_names = .{
        .account_link_id = "AccountLinkId",
        .account_link_status = "AccountLinkStatus",
        .source_account_id = "SourceAccountId",
        .target_account_id = "TargetAccountId",
    };
};
