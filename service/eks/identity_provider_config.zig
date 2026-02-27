/// An object representing an identity provider configuration.
pub const IdentityProviderConfig = struct {
    /// The name of the identity provider configuration.
    name: []const u8,

    /// The type of the identity provider configuration. The only type available is
    /// `oidc`.
    type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
