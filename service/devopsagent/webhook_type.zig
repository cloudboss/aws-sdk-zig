const std = @import("std");

/// Webhook authentication type.
pub const WebhookType = enum {
    /// HMAC-based webhook authentication
    hmac,
    /// API key-based webhook authentication
    api_key,
    /// GitLab-specific webhook authentication
    gitlab,
    /// pagerduty-specific webhook authentication
    pagerduty,

    pub const json_field_names = .{
        .hmac = "hmac",
        .api_key = "apikey",
        .gitlab = "gitlab",
        .pagerduty = "pagerduty",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hmac => "hmac",
            .api_key => "apikey",
            .gitlab => "gitlab",
            .pagerduty => "pagerduty",
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
