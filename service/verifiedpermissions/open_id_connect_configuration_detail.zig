const OpenIdConnectGroupConfigurationDetail = @import("open_id_connect_group_configuration_detail.zig").OpenIdConnectGroupConfigurationDetail;
const OpenIdConnectTokenSelectionDetail = @import("open_id_connect_token_selection_detail.zig").OpenIdConnectTokenSelectionDetail;

/// Contains configuration details of an OpenID Connect (OIDC) identity
/// provider, or identity source, that Verified Permissions can use to generate
/// entities from authenticated identities. It specifies the issuer URL, token
/// type that you want to use, and policy store entity details.
///
/// This data type is part of a
/// [ConfigurationDetail](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ConfigurationDetail.html) structure, which is a parameter to [GetIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_GetIdentitySource.html).
pub const OpenIdConnectConfigurationDetail = struct {
    /// A descriptive string that you want to prefix to user entities from your OIDC
    /// identity provider. For example, if you set an `entityIdPrefix` of
    /// `MyOIDCProvider`, you can reference principals in your policies in the
    /// format `MyCorp::User::MyOIDCProvider|Carlos`.
    entity_id_prefix: ?[]const u8,

    /// The claim in OIDC identity provider tokens that indicates a user's group
    /// membership, and the entity type that you want to map it to. For example,
    /// this object can map the contents of a `groups` claim to `MyCorp::UserGroup`.
    group_configuration: ?OpenIdConnectGroupConfigurationDetail,

    /// The issuer URL of an OIDC identity provider. This URL must have an OIDC
    /// discovery endpoint at the path `.well-known/openid-configuration`.
    issuer: []const u8,

    /// The token type that you want to process from your OIDC identity provider.
    /// Your policy store can process either identity (ID) or access tokens from a
    /// given OIDC identity source.
    token_selection: OpenIdConnectTokenSelectionDetail,

    pub const json_field_names = .{
        .entity_id_prefix = "entityIdPrefix",
        .group_configuration = "groupConfiguration",
        .issuer = "issuer",
        .token_selection = "tokenSelection",
    };
};
