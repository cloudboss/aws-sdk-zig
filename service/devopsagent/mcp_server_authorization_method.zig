const std = @import("std");

/// Supported authorization methods for MCP servers.
pub const MCPServerAuthorizationMethod = enum {
    /// OAuth 2.0 client credentials flow.
    oauth_client_credentials,
    /// OAuth 2.0 three-legged authorization flow.
    oauth_3_lo,
    /// API key-based authentication.
    api_key,
    /// Bearer token authentication (RFC 6750).
    bearer_token,

    pub const json_field_names = .{
        .oauth_client_credentials = "oauth-client-credentials",
        .oauth_3_lo = "oauth-3lo",
        .api_key = "api-key",
        .bearer_token = "bearer-token",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .oauth_client_credentials => "oauth-client-credentials",
            .oauth_3_lo => "oauth-3lo",
            .api_key => "api-key",
            .bearer_token => "bearer-token",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
