const aws = @import("aws");

const AuthorizationCodeProperties = @import("authorization_code_properties.zig").AuthorizationCodeProperties;
const OAuth2ClientApplication = @import("o_auth_2_client_application.zig").OAuth2ClientApplication;
const OAuth2Credentials = @import("o_auth_2_credentials.zig").OAuth2Credentials;
const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;

/// A structure containing properties for OAuth2 in the CreateConnection
/// request.
pub const OAuth2PropertiesInput = struct {
    /// The set of properties required for the the OAuth2 `AUTHORIZATION_CODE` grant
    /// type.
    authorization_code_properties: ?AuthorizationCodeProperties = null,

    /// The client application type in the CreateConnection request. For example,
    /// `AWS_MANAGED` or `USER_MANAGED`.
    o_auth_2_client_application: ?OAuth2ClientApplication = null,

    /// The credentials used when the authentication type is OAuth2 authentication.
    o_auth_2_credentials: ?OAuth2Credentials = null,

    /// The OAuth2 grant type in the CreateConnection request. For example,
    /// `AUTHORIZATION_CODE`, `JWT_BEARER`, or `CLIENT_CREDENTIALS`.
    o_auth_2_grant_type: ?OAuth2GrantType = null,

    /// The URL of the provider's authentication server, to exchange an
    /// authorization code for an access token.
    token_url: ?[]const u8 = null,

    /// A map of parameters that are added to the token `GET` request.
    token_url_parameters_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorization_code_properties = "AuthorizationCodeProperties",
        .o_auth_2_client_application = "OAuth2ClientApplication",
        .o_auth_2_credentials = "OAuth2Credentials",
        .o_auth_2_grant_type = "OAuth2GrantType",
        .token_url = "TokenUrl",
        .token_url_parameters_map = "TokenUrlParametersMap",
    };
};
