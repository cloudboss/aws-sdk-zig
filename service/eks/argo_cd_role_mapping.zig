const SsoIdentity = @import("sso_identity.zig").SsoIdentity;
const ArgoCdRole = @import("argo_cd_role.zig").ArgoCdRole;

/// A mapping between an Argo CD role and IAM Identity CenterIAM; Identity
/// Center identities. This defines which users or groups have specific
/// permissions in Argo CD.
pub const ArgoCdRoleMapping = struct {
    /// A list of IAM Identity CenterIAM; Identity Center identities (users or
    /// groups) that should be assigned this Argo CD role.
    identities: []const SsoIdentity,

    /// The Argo CD role to assign. Valid values are:
    ///
    /// * `ADMIN` – Full administrative access to Argo CD.
    ///
    /// * `EDITOR` – Edit access to Argo CD resources.
    ///
    /// * `VIEWER` – Read-only access to Argo CD resources.
    role: ArgoCdRole,

    pub const json_field_names = .{
        .identities = "identities",
        .role = "role",
    };
};
