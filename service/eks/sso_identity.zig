const SsoIdentityType = @import("sso_identity_type.zig").SsoIdentityType;

/// An IAM Identity CenterIAM; Identity Center identity (user or group) that can
/// be assigned permissions in a capability.
pub const SsoIdentity = struct {
    /// The unique identifier of the IAM Identity CenterIAM; Identity Center user or
    /// group.
    id: []const u8,

    /// The type of identity. Valid values are `SSO_USER` or `SSO_GROUP`.
    @"type": SsoIdentityType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};
