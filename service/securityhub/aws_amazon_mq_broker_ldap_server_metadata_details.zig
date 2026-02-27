/// The metadata of the Lightweight Directory Access Protocol (LDAP) server used
/// to authenticate and authorize
/// connections to the broker. This is an optional failover server.
pub const AwsAmazonMqBrokerLdapServerMetadataDetails = struct {
    /// Specifies the location of the LDAP server, such as Amazon Web Services
    /// Directory Service for Microsoft Active Directory.
    hosts: ?[]const []const u8,

    /// The distinguished name of the node in the directory information tree (DIT)
    /// to search for roles or groups.
    role_base: ?[]const u8,

    /// The group name attribute in a role entry whose value is the name of that
    /// role.
    role_name: ?[]const u8,

    /// The LDAP search filter used to find roles within the `roleBase`.
    role_search_matching: ?[]const u8,

    /// The directory search scope for the role. If set to `true`, the scope is to
    /// search the entire subtree.
    role_search_subtree: ?bool,

    /// A username for the service account, which is an account in your LDAP server
    /// that has access to initiate a connection.
    service_account_username: ?[]const u8,

    /// Selects a particular subtree of the directory information tree (DIT) to
    /// search for user entries.
    user_base: ?[]const u8,

    /// The name of the LDAP attribute in the user's directory entry for the user's
    /// group membership.
    user_role_name: ?[]const u8,

    /// The LDAP search filter used to find users within the `userBase`.
    user_search_matching: ?[]const u8,

    /// The directory search scope for the user. If set to true, the scope is to
    /// search the entire subtree.
    user_search_subtree: ?bool,

    pub const json_field_names = .{
        .hosts = "Hosts",
        .role_base = "RoleBase",
        .role_name = "RoleName",
        .role_search_matching = "RoleSearchMatching",
        .role_search_subtree = "RoleSearchSubtree",
        .service_account_username = "ServiceAccountUsername",
        .user_base = "UserBase",
        .user_role_name = "UserRoleName",
        .user_search_matching = "UserSearchMatching",
        .user_search_subtree = "UserSearchSubtree",
    };
};
