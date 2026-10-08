const aws = @import("aws");

const RegistryRecordOAuthGrantType = @import("registry_record_o_auth_grant_type.zig").RegistryRecordOAuthGrantType;

/// The configuration for an OAuth 2.0 credential provider that authenticates
/// requests to a registry record's source.
pub const RegistryRecordOAuthCredentialProvider = struct {
    /// Additional parameters to include in the OAuth 2.0 token request.
    custom_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The OAuth 2.0 grant type used to obtain access tokens.
    grant_type: ?RegistryRecordOAuthGrantType = null,

    /// The Amazon Resource Name (ARN) of the OAuth 2.0 credential provider resource
    /// in Amazon Bedrock AgentCore Identity.
    provider_arn: []const u8,

    /// The OAuth 2.0 scopes to request when obtaining access tokens.
    scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .custom_parameters = "customParameters",
        .grant_type = "grantType",
        .provider_arn = "providerArn",
        .scopes = "scopes",
    };
};
