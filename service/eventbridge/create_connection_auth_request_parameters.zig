const CreateConnectionApiKeyAuthRequestParameters = @import("create_connection_api_key_auth_request_parameters.zig").CreateConnectionApiKeyAuthRequestParameters;
const CreateConnectionBasicAuthRequestParameters = @import("create_connection_basic_auth_request_parameters.zig").CreateConnectionBasicAuthRequestParameters;
const ConnectivityResourceParameters = @import("connectivity_resource_parameters.zig").ConnectivityResourceParameters;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;
const CreateConnectionOAuthRequestParameters = @import("create_connection_o_auth_request_parameters.zig").CreateConnectionOAuthRequestParameters;

/// The authorization parameters for the connection.
///
/// You must include only authorization parameters for the `AuthorizationType`
/// you specify.
pub const CreateConnectionAuthRequestParameters = struct {
    /// The API
    /// key authorization parameters to use for the connection.
    api_key_auth_parameters: ?CreateConnectionApiKeyAuthRequestParameters = null,

    /// The Basic
    /// authorization parameters to use for the connection.
    basic_auth_parameters: ?CreateConnectionBasicAuthRequestParameters = null,

    /// If you specify a private OAuth endpoint, the parameters for EventBridge to
    /// use when authenticating against the endpoint.
    ///
    /// For more information, see [Authorization methods for
    /// connections](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-target-connection-auth.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    connectivity_parameters: ?ConnectivityResourceParameters = null,

    /// The API key authorization
    /// parameters to use for the connection. Note that if you include additional
    /// parameters for the
    /// target of a rule via `HttpParameters`, including query strings, the
    /// parameters
    /// added for the connection take precedence.
    invocation_http_parameters: ?ConnectionHttpParameters = null,

    /// The OAuth
    /// authorization parameters to use for the connection.
    o_auth_parameters: ?CreateConnectionOAuthRequestParameters = null,

    pub const json_field_names = .{
        .api_key_auth_parameters = "ApiKeyAuthParameters",
        .basic_auth_parameters = "BasicAuthParameters",
        .connectivity_parameters = "ConnectivityParameters",
        .invocation_http_parameters = "InvocationHttpParameters",
        .o_auth_parameters = "OAuthParameters",
    };
};
