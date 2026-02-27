const AuthorizationCodeGrant = @import("authorization_code_grant.zig").AuthorizationCodeGrant;
const JwtBearerGrant = @import("jwt_bearer_grant.zig").JwtBearerGrant;
const RefreshTokenGrant = @import("refresh_token_grant.zig").RefreshTokenGrant;
const TokenExchangeGrant = @import("token_exchange_grant.zig").TokenExchangeGrant;

/// The Grant union represents the set of possible configuration options for the
/// selected grant type. Exactly one member of the union must be specified, and
/// must match the grant type selected.
pub const Grant = union(enum) {
    /// Configuration options for the `authorization_code` grant type.
    authorization_code: ?AuthorizationCodeGrant,
    /// Configuration options for the `urn:ietf:params:oauth:grant-type:jwt-bearer`
    /// grant type.
    jwt_bearer: ?JwtBearerGrant,
    /// Configuration options for the `refresh_token` grant type.
    refresh_token: ?RefreshTokenGrant,
    /// Configuration options for the
    /// `urn:ietf:params:oauth:grant-type:token-exchange` grant type.
    token_exchange: ?TokenExchangeGrant,

    pub const json_field_names = .{
        .authorization_code = "AuthorizationCode",
        .jwt_bearer = "JwtBearer",
        .refresh_token = "RefreshToken",
        .token_exchange = "TokenExchange",
    };
};
