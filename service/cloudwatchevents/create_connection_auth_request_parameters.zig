const CreateConnectionApiKeyAuthRequestParameters = @import("create_connection_api_key_auth_request_parameters.zig").CreateConnectionApiKeyAuthRequestParameters;
const CreateConnectionBasicAuthRequestParameters = @import("create_connection_basic_auth_request_parameters.zig").CreateConnectionBasicAuthRequestParameters;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;
const CreateConnectionOAuthRequestParameters = @import("create_connection_o_auth_request_parameters.zig").CreateConnectionOAuthRequestParameters;

/// Contains the authorization parameters for the connection.
pub const CreateConnectionAuthRequestParameters = struct {
    /// A `CreateConnectionApiKeyAuthRequestParameters` object that contains the API
    /// key authorization parameters to use for the connection.
    api_key_auth_parameters: ?CreateConnectionApiKeyAuthRequestParameters = null,

    /// A `CreateConnectionBasicAuthRequestParameters` object that contains the
    /// Basic
    /// authorization parameters to use for the connection.
    basic_auth_parameters: ?CreateConnectionBasicAuthRequestParameters = null,

    /// A `ConnectionHttpParameters` object that contains the API key authorization
    /// parameters to use for the connection. Note that if you include additional
    /// parameters for the
    /// target of a rule via `HttpParameters`, including query strings, the
    /// parameters
    /// added for the connection take precedence.
    invocation_http_parameters: ?ConnectionHttpParameters = null,

    /// A `CreateConnectionOAuthRequestParameters` object that contains the OAuth
    /// authorization parameters to use for the connection.
    o_auth_parameters: ?CreateConnectionOAuthRequestParameters = null,

    pub const json_field_names = .{
        .api_key_auth_parameters = "ApiKeyAuthParameters",
        .basic_auth_parameters = "BasicAuthParameters",
        .invocation_http_parameters = "InvocationHttpParameters",
        .o_auth_parameters = "OAuthParameters",
    };
};
