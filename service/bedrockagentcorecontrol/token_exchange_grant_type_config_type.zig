const ActorTokenContentType = @import("actor_token_content_type.zig").ActorTokenContentType;

/// Configuration for RFC 8693 token exchange.
pub const TokenExchangeGrantTypeConfigType = struct {
    /// The content type for the actor token in the token exchange.
    actor_token_content: ActorTokenContentType,

    /// The scopes for the actor token. Only valid when actorTokenContent is M2M.
    actor_token_scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .actor_token_content = "actorTokenContent",
        .actor_token_scopes = "actorTokenScopes",
    };
};
