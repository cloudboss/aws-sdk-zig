const AssertionAttributes = @import("assertion_attributes.zig").AssertionAttributes;
const IdpMetadata = @import("idp_metadata.zig").IdpMetadata;
const RoleValues = @import("role_values.zig").RoleValues;

/// A structure containing information about how this workspace works with SAML.
pub const SamlConfiguration = struct {
    /// Lists which organizations defined in the SAML assertion are allowed to use
    /// the Amazon Managed Grafana workspace. If this is empty, all organizations in
    /// the assertion attribute have access.
    allowed_organizations: ?[]const []const u8 = null,

    /// A structure that defines which attributes in the SAML assertion are to be
    /// used to define information about the users authenticated by that IdP to use
    /// the workspace.
    assertion_attributes: ?AssertionAttributes = null,

    /// A structure containing the identity provider (IdP) metadata used to
    /// integrate the identity provider with this workspace.
    idp_metadata: IdpMetadata,

    /// How long a sign-on session by a SAML user is valid, before the user has to
    /// sign on again.
    login_validity_duration: i32 = 0,

    /// A structure containing arrays that map group names in the SAML assertion to
    /// the Grafana `Admin` and `Editor` roles in the workspace.
    role_values: ?RoleValues = null,

    pub const json_field_names = .{
        .allowed_organizations = "allowedOrganizations",
        .assertion_attributes = "assertionAttributes",
        .idp_metadata = "idpMetadata",
        .login_validity_duration = "loginValidityDuration",
        .role_values = "roleValues",
    };
};
