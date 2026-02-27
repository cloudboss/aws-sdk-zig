const aws = @import("aws");

const AuthorizationCodeProperties = @import("authorization_code_properties.zig").AuthorizationCodeProperties;
const OAuth2ClientApplication = @import("o_auth_2_client_application.zig").OAuth2ClientApplication;
const GlueOAuth2Credentials = @import("glue_o_auth_2_credentials.zig").GlueOAuth2Credentials;
const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;

/// The OAuth2 properties.
pub const OAuth2Properties = struct {
    /// The authorization code properties of the OAuth2 properties.
    authorization_code_properties: ?AuthorizationCodeProperties,

    /// The OAuth2 client application of the OAuth2 properties.
    o_auth_2_client_application: ?OAuth2ClientApplication,

    /// The OAuth2 credentials of the OAuth2 properties.
    o_auth_2_credentials: ?GlueOAuth2Credentials,

    /// The OAuth2 grant type of the OAuth2 properties.
    o_auth_2_grant_type: ?OAuth2GrantType,

    /// The OAuth2 token URL of the OAuth2 properties.
    token_url: ?[]const u8,

    /// The OAuth2 token URL parameter map of the OAuth2 properties.
    token_url_parameters_map: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .authorization_code_properties = "authorizationCodeProperties",
        .o_auth_2_client_application = "oAuth2ClientApplication",
        .o_auth_2_credentials = "oAuth2Credentials",
        .o_auth_2_grant_type = "oAuth2GrantType",
        .token_url = "tokenUrl",
        .token_url_parameters_map = "tokenUrlParametersMap",
    };
};
