const AssociationStatus = @import("association_status.zig").AssociationStatus;

/// Describes a connection alias association that is used for cross-Region
/// redirection. For
/// more information, see [ Cross-Region
/// Redirection for Amazon
/// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
pub const ConnectionAliasAssociation = struct {
    /// The identifier of the Amazon Web Services account that associated the
    /// connection alias
    /// with a directory.
    associated_account_id: ?[]const u8,

    /// The association status of the connection alias.
    association_status: ?AssociationStatus,

    /// The identifier of the connection alias association. You use the connection
    /// identifier in
    /// the DNS TXT record when you're configuring your DNS routing policies.
    connection_identifier: ?[]const u8,

    /// The identifier of the directory associated with a connection alias.
    resource_id: ?[]const u8,

    pub const json_field_names = .{
        .associated_account_id = "AssociatedAccountId",
        .association_status = "AssociationStatus",
        .connection_identifier = "ConnectionIdentifier",
        .resource_id = "ResourceId",
    };
};
