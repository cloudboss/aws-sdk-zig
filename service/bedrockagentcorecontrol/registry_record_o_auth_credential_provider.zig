const aws = @import("aws");

const RegistryRecordOAuthGrantType = @import("registry_record_o_auth_grant_type.zig").RegistryRecordOAuthGrantType;

/// OAuth credential provider configuration for authenticating with an external
/// source during synchronization.
pub const RegistryRecordOAuthCredentialProvider = struct {
    /// Additional custom parameters for the OAuth flow.
    custom_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The OAuth grant type. Currently only `CLIENT_CREDENTIALS` is supported.
    grant_type: ?RegistryRecordOAuthGrantType = null,

    /// The Amazon Resource Name (ARN) of the OAuth credential provider resource.
    provider_arn: []const u8,

    /// The OAuth scopes to request during authentication.
    scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .custom_parameters = "customParameters",
        .grant_type = "grantType",
        .provider_arn = "providerArn",
        .scopes = "scopes",
    };
};
