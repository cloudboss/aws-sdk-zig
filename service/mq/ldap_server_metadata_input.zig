/// Optional. The metadata of the LDAP server used to authenticate and authorize
/// connections to the broker.
///
/// Does not apply to RabbitMQ brokers.
pub const LdapServerMetadataInput = struct {
    /// Specifies the location of the LDAP server such as Directory Service for
    /// Microsoft Active Directory. Optional failover server.
    hosts: []const []const u8,

    /// The distinguished name of the node in the directory information tree (DIT)
    /// to search for roles or groups. For example, ou=group, ou=corp, dc=corp,
    /// dc=example, dc=com.
    role_base: []const u8,

    /// Specifies the LDAP attribute that identifies the group name attribute in the
    /// object returned from the group membership query.
    role_name: ?[]const u8 = null,

    /// The LDAP search filter used to find roles within the roleBase. The
    /// distinguished name of the user matched by userSearchMatching is substituted
    /// into the {0} placeholder in the search filter. The client's username is
    /// substituted into the {1} placeholder. For example, if you set this option to
    /// (member=uid={1})for the user janedoe, the search filter becomes
    /// (member=uid=janedoe) after string substitution. It matches all role entries
    /// that have a member attribute equal to uid=janedoe under the subtree selected
    /// by the roleBase.
    role_search_matching: []const u8,

    /// The directory search scope for the role. If set to true, scope is to search
    /// the entire subtree.
    role_search_subtree: ?bool = null,

    /// Service account password. A service account is an account in your LDAP
    /// server that has access to initiate a connection. For example,
    /// cn=admin,dc=corp, dc=example,
    /// dc=com.
    service_account_password: []const u8,

    /// Service account username. A service account is an account in your LDAP
    /// server that has access to initiate a connection. For example,
    /// cn=admin,dc=corp, dc=example,
    /// dc=com.
    service_account_username: []const u8,

    /// Select a particular subtree of the directory information tree (DIT) to
    /// search for user entries. The subtree is specified by a DN, which specifies
    /// the base node of the subtree. For example, by setting this option to
    /// ou=Users,ou=corp, dc=corp,
    /// dc=example, dc=com, the search for user entries is restricted to the subtree
    /// beneath ou=Users, ou=corp, dc=corp, dc=example, dc=com.
    user_base: []const u8,

    /// Specifies the name of the LDAP attribute for the user group membership.
    user_role_name: ?[]const u8 = null,

    /// The LDAP search filter used to find users within the userBase. The client's
    /// username is substituted into the {0} placeholder in the search filter. For
    /// example, if this option is set to (uid={0}) and the received username is
    /// janedoe, the search filter becomes (uid=janedoe) after string substitution.
    /// It will result in matching an entry like uid=janedoe, ou=Users,ou=corp,
    /// dc=corp, dc=example,
    /// dc=com.
    user_search_matching: []const u8,

    /// The directory search scope for the user. If set to true, scope is to search
    /// the entire subtree.
    user_search_subtree: ?bool = null,

    pub const json_field_names = .{
        .hosts = "Hosts",
        .role_base = "RoleBase",
        .role_name = "RoleName",
        .role_search_matching = "RoleSearchMatching",
        .role_search_subtree = "RoleSearchSubtree",
        .service_account_password = "ServiceAccountPassword",
        .service_account_username = "ServiceAccountUsername",
        .user_base = "UserBase",
        .user_role_name = "UserRoleName",
        .user_search_matching = "UserSearchMatching",
        .user_search_subtree = "UserSearchSubtree",
    };
};
