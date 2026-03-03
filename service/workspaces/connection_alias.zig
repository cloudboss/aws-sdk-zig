const ConnectionAliasAssociation = @import("connection_alias_association.zig").ConnectionAliasAssociation;
const ConnectionAliasState = @import("connection_alias_state.zig").ConnectionAliasState;

/// Describes a connection alias. Connection aliases are used for cross-Region
/// redirection.
/// For more information, see [ Cross-Region
/// Redirection for Amazon
/// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
pub const ConnectionAlias = struct {
    /// The identifier of the connection alias.
    alias_id: ?[]const u8 = null,

    /// The association status of the connection alias.
    associations: ?[]const ConnectionAliasAssociation = null,

    /// The connection string specified for the connection alias. The connection
    /// string must be
    /// in the form of a fully qualified domain name (FQDN), such as
    /// `www.example.com`.
    connection_string: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services account that owns the connection
    /// alias.
    owner_account_id: ?[]const u8 = null,

    /// The current state of the connection alias.
    state: ?ConnectionAliasState = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .associations = "Associations",
        .connection_string = "ConnectionString",
        .owner_account_id = "OwnerAccountId",
        .state = "State",
    };
};
