/// Describes the permissions for a connection alias. Connection aliases are
/// used for
/// cross-Region redirection. For more information, see [ Cross-Region
/// Redirection for Amazon
/// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
pub const ConnectionAliasPermission = struct {
    /// Indicates whether the specified Amazon Web Services account is allowed to
    /// associate the
    /// connection alias with a directory.
    allow_association: bool,

    /// The identifier of the Amazon Web Services account that the connection alias
    /// is shared
    /// with.
    shared_account_id: []const u8,

    pub const json_field_names = .{
        .allow_association = "AllowAssociation",
        .shared_account_id = "SharedAccountId",
    };
};
