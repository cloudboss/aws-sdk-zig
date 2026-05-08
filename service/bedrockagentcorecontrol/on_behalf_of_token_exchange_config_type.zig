const OnBehalfOfTokenExchangeGrantTypeType = @import("on_behalf_of_token_exchange_grant_type_type.zig").OnBehalfOfTokenExchangeGrantTypeType;
const TokenExchangeGrantTypeConfigType = @import("token_exchange_grant_type_config_type.zig").TokenExchangeGrantTypeConfigType;

/// Configuration for on-behalf-of token exchange.
pub const OnBehalfOfTokenExchangeConfigType = struct {
    /// The grant type for the on-behalf-of token exchange.
    grant_type: OnBehalfOfTokenExchangeGrantTypeType,

    /// Configuration specific to the TOKEN_EXCHANGE grant type (RFC 8693).
    token_exchange_grant_type_config: ?TokenExchangeGrantTypeConfigType = null,

    pub const json_field_names = .{
        .grant_type = "grantType",
        .token_exchange_grant_type_config = "tokenExchangeGrantTypeConfig",
    };
};
