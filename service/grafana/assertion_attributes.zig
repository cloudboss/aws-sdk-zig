/// A structure that defines which attributes in the IdP assertion are to be
/// used to define information about the users authenticated by the IdP to use
/// the workspace.
pub const AssertionAttributes = struct {
    /// The name of the attribute within the SAML assertion to use as the email
    /// names for SAML users.
    email: ?[]const u8 = null,

    /// The name of the attribute within the SAML assertion to use as the user full
    /// "friendly" names for user groups.
    groups: ?[]const u8 = null,

    /// The name of the attribute within the SAML assertion to use as the login
    /// names for SAML users.
    login: ?[]const u8 = null,

    /// The name of the attribute within the SAML assertion to use as the user full
    /// "friendly" names for SAML users.
    name: ?[]const u8 = null,

    /// The name of the attribute within the SAML assertion to use as the user full
    /// "friendly" names for the users' organizations.
    org: ?[]const u8 = null,

    /// The name of the attribute within the SAML assertion to use as the user
    /// roles.
    role: ?[]const u8 = null,

    pub const json_field_names = .{
        .email = "email",
        .groups = "groups",
        .login = "login",
        .name = "name",
        .org = "org",
        .role = "role",
    };
};
