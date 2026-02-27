const UpdateConnectionApiKeyAuthRequestParameters = @import("update_connection_api_key_auth_request_parameters.zig").UpdateConnectionApiKeyAuthRequestParameters;
const UpdateConnectionBasicAuthRequestParameters = @import("update_connection_basic_auth_request_parameters.zig").UpdateConnectionBasicAuthRequestParameters;
const ConnectivityResourceParameters = @import("connectivity_resource_parameters.zig").ConnectivityResourceParameters;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;
const UpdateConnectionOAuthRequestParameters = @import("update_connection_o_auth_request_parameters.zig").UpdateConnectionOAuthRequestParameters;

/// Contains the additional parameters to use for the connection.
pub const UpdateConnectionAuthRequestParameters = struct {
    /// The
    /// authorization parameters for API key authorization.
    api_key_auth_parameters: ?UpdateConnectionApiKeyAuthRequestParameters,

    /// The
    /// authorization parameters for Basic authorization.
    basic_auth_parameters: ?UpdateConnectionBasicAuthRequestParameters,

    /// If you specify a private OAuth endpoint, the parameters for EventBridge to
    /// use when authenticating against the endpoint.
    ///
    /// For more information, see [Authorization methods for
    /// connections](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-target-connection-auth.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    connectivity_parameters: ?ConnectivityResourceParameters,

    /// The additional parameters to
    /// use for the connection.
    invocation_http_parameters: ?ConnectionHttpParameters,

    /// The
    /// authorization parameters for OAuth authorization.
    o_auth_parameters: ?UpdateConnectionOAuthRequestParameters,

    pub const json_field_names = .{
        .api_key_auth_parameters = "ApiKeyAuthParameters",
        .basic_auth_parameters = "BasicAuthParameters",
        .connectivity_parameters = "ConnectivityParameters",
        .invocation_http_parameters = "InvocationHttpParameters",
        .o_auth_parameters = "OAuthParameters",
    };
};
