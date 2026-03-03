const ConnectionApiKeyAuthResponseParameters = @import("connection_api_key_auth_response_parameters.zig").ConnectionApiKeyAuthResponseParameters;
const ConnectionBasicAuthResponseParameters = @import("connection_basic_auth_response_parameters.zig").ConnectionBasicAuthResponseParameters;
const DescribeConnectionConnectivityParameters = @import("describe_connection_connectivity_parameters.zig").DescribeConnectionConnectivityParameters;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;
const ConnectionOAuthResponseParameters = @import("connection_o_auth_response_parameters.zig").ConnectionOAuthResponseParameters;

/// Tthe authorization parameters to use for the connection.
pub const ConnectionAuthResponseParameters = struct {
    /// The API Key parameters to use for authorization.
    api_key_auth_parameters: ?ConnectionApiKeyAuthResponseParameters = null,

    /// The authorization parameters for Basic authorization.
    basic_auth_parameters: ?ConnectionBasicAuthResponseParameters = null,

    /// For private OAuth authentication endpoints. The parameters EventBridge uses
    /// to authenticate against the endpoint.
    ///
    /// For more information, see [Authorization methods for
    /// connections](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-target-connection-auth.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    connectivity_parameters: ?DescribeConnectionConnectivityParameters = null,

    /// Additional parameters for the connection that are passed through with every
    /// invocation to
    /// the HTTP endpoint.
    invocation_http_parameters: ?ConnectionHttpParameters = null,

    /// The OAuth parameters to use for authorization.
    o_auth_parameters: ?ConnectionOAuthResponseParameters = null,

    pub const json_field_names = .{
        .api_key_auth_parameters = "ApiKeyAuthParameters",
        .basic_auth_parameters = "BasicAuthParameters",
        .connectivity_parameters = "ConnectivityParameters",
        .invocation_http_parameters = "InvocationHttpParameters",
        .o_auth_parameters = "OAuthParameters",
    };
};
