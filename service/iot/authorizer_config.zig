/// An object that specifies the authorization service for a domain.
pub const AuthorizerConfig = struct {
    /// A Boolean that specifies whether the domain configuration's authorization
    /// service can be overridden.
    allow_authorizer_override: ?bool,

    /// The name of the authorization service for a domain configuration.
    default_authorizer_name: ?[]const u8,

    pub const json_field_names = .{
        .allow_authorizer_override = "allowAuthorizerOverride",
        .default_authorizer_name = "defaultAuthorizerName",
    };
};
