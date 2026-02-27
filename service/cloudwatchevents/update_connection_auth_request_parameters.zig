const UpdateConnectionApiKeyAuthRequestParameters = @import("update_connection_api_key_auth_request_parameters.zig").UpdateConnectionApiKeyAuthRequestParameters;
const UpdateConnectionBasicAuthRequestParameters = @import("update_connection_basic_auth_request_parameters.zig").UpdateConnectionBasicAuthRequestParameters;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;
const UpdateConnectionOAuthRequestParameters = @import("update_connection_o_auth_request_parameters.zig").UpdateConnectionOAuthRequestParameters;

/// Contains the additional parameters to use for the connection.
pub const UpdateConnectionAuthRequestParameters = struct {
    /// A `UpdateConnectionApiKeyAuthRequestParameters` object that contains the
    /// authorization parameters for API key authorization.
    api_key_auth_parameters: ?UpdateConnectionApiKeyAuthRequestParameters,

    /// A `UpdateConnectionBasicAuthRequestParameters` object that contains the
    /// authorization parameters for Basic authorization.
    basic_auth_parameters: ?UpdateConnectionBasicAuthRequestParameters,

    /// A `ConnectionHttpParameters` object that contains the additional parameters
    /// to
    /// use for the connection.
    invocation_http_parameters: ?ConnectionHttpParameters,

    /// A `UpdateConnectionOAuthRequestParameters` object that contains the
    /// authorization parameters for OAuth authorization.
    o_auth_parameters: ?UpdateConnectionOAuthRequestParameters,

    pub const json_field_names = .{
        .api_key_auth_parameters = "ApiKeyAuthParameters",
        .basic_auth_parameters = "BasicAuthParameters",
        .invocation_http_parameters = "InvocationHttpParameters",
        .o_auth_parameters = "OAuthParameters",
    };
};
