const aws = @import("aws");

const OAuth2ClientApplication = @import("o_auth_2_client_application.zig").OAuth2ClientApplication;
const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;

/// A structure containing properties for OAuth2 authentication.
pub const OAuth2Properties = struct {
    /// The client application type. For example, AWS_MANAGED or USER_MANAGED.
    o_auth_2_client_application: ?OAuth2ClientApplication,

    /// The OAuth2 grant type. For example, `AUTHORIZATION_CODE`, `JWT_BEARER`, or
    /// `CLIENT_CREDENTIALS`.
    o_auth_2_grant_type: ?OAuth2GrantType,

    /// The URL of the provider's authentication server, to exchange an
    /// authorization code for an access token.
    token_url: ?[]const u8,

    /// A map of parameters that are added to the token `GET` request.
    token_url_parameters_map: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .o_auth_2_client_application = "OAuth2ClientApplication",
        .o_auth_2_grant_type = "OAuth2GrantType",
        .token_url = "TokenUrl",
        .token_url_parameters_map = "TokenUrlParametersMap",
    };
};
