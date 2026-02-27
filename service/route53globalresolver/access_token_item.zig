const TokenStatus = @import("token_status.zig").TokenStatus;

/// Summary information about a token.
pub const AccessTokenItem = struct {
    /// The Amazon Resource Name (ARN) of the token.
    arn: []const u8,

    /// The date and time when the token was created.
    created_at: i64,

    /// The ID of the DNS view associated with the token.
    dns_view_id: []const u8,

    /// The date and time when the token expires.
    expires_at: i64,

    /// The ID of the global resolver associated with the token.
    global_resolver_id: []const u8,

    /// The unique identifier of the token.
    id: []const u8,

    /// The name of the token.
    name: ?[]const u8,

    /// The current status of the token.
    status: TokenStatus,

    /// The date and time when the token was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .dns_view_id = "dnsViewId",
        .expires_at = "expiresAt",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
