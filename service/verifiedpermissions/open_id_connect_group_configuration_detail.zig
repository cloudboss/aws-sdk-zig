/// The claim in OIDC identity provider tokens that indicates a user's group
/// membership, and the entity type that you want to map it to. For example,
/// this object can map the contents of a `groups` claim to `MyCorp::UserGroup`.
///
/// This data type is part of a
/// [OpenIdConnectConfigurationDetail](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_OpenIdConnectConfigurationDetail.html) structure, which is a parameter of [GetIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_GetIdentitySource.html).
pub const OpenIdConnectGroupConfigurationDetail = struct {
    /// The token claim that you want Verified Permissions to interpret as group
    /// membership. For example, `groups`.
    group_claim: []const u8,

    /// The policy store entity type that you want to map your users' group claim
    /// to. For example, `MyCorp::UserGroup`. A group entity type is an entity that
    /// can have a user entity type as a member.
    group_entity_type: []const u8,

    pub const json_field_names = .{
        .group_claim = "groupClaim",
        .group_entity_type = "groupEntityType",
    };
};
