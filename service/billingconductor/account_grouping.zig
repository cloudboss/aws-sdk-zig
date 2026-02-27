/// The set of accounts that will be under the billing group. The set of
/// accounts resemble the linked accounts in a consolidated billing family.
pub const AccountGrouping = struct {
    /// Specifies if this billing group will automatically associate newly added
    /// Amazon Web Services accounts that join your consolidated billing family.
    auto_associate: ?bool,

    /// The account IDs that make up the billing group. Account IDs must be a part
    /// of the consolidated billing family, and not associated with another billing
    /// group.
    linked_account_ids: []const []const u8 = &.{},

    /// The Amazon Resource Name (ARN) that identifies the transfer relationship
    /// owned by the Bill Transfer account (caller account). When specified, the
    /// PrimaryAccountId is no longer required.
    responsibility_transfer_arn: ?[]const u8,

    pub const json_field_names = .{
        .auto_associate = "AutoAssociate",
        .linked_account_ids = "LinkedAccountIds",
        .responsibility_transfer_arn = "ResponsibilityTransferArn",
    };
};
