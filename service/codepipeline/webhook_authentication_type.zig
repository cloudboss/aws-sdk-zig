const std = @import("std");

pub const WebhookAuthenticationType = enum {
    github_hmac,
    ip,
    unauthenticated,

    pub const json_field_names = .{
        .github_hmac = "GITHUB_HMAC",
        .ip = "IP",
        .unauthenticated = "UNAUTHENTICATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .github_hmac => "GITHUB_HMAC",
            .ip => "IP",
            .unauthenticated => "UNAUTHENTICATED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
