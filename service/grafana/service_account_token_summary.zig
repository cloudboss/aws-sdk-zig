/// A structure that contains the information about a service account token.
pub const ServiceAccountTokenSummary = struct {
    /// When the service account token was created.
    created_at: i64,

    /// When the service account token will expire.
    expires_at: i64,

    /// The unique ID of the service account token.
    id: []const u8,

    /// The last time the token was used to authorize a Grafana HTTP API.
    last_used_at: ?i64,

    /// The name of the service account token.
    name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .id = "id",
        .last_used_at = "lastUsedAt",
        .name = "name",
    };
};
