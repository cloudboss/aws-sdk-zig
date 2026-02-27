const ApiKeyCredentialLocation = @import("api_key_credential_location.zig").ApiKeyCredentialLocation;

/// An API key credential provider for gateway authentication. This structure
/// contains the configuration for authenticating with the target endpoint using
/// an API key.
pub const GatewayApiKeyCredentialProvider = struct {
    /// The location of the API key credential. This field specifies where in the
    /// request the API key should be placed.
    credential_location: ?ApiKeyCredentialLocation,

    /// The name of the credential parameter for the API key. This parameter name is
    /// used when sending the API key to the target endpoint.
    credential_parameter_name: ?[]const u8,

    /// The prefix for the API key credential. This prefix is added to the API key
    /// when sending it to the target endpoint.
    credential_prefix: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the API key credential provider. This ARN
    /// identifies the provider in Amazon Web Services.
    provider_arn: []const u8,

    pub const json_field_names = .{
        .credential_location = "credentialLocation",
        .credential_parameter_name = "credentialParameterName",
        .credential_prefix = "credentialPrefix",
        .provider_arn = "providerArn",
    };
};
