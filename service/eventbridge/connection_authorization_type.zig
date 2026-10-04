const std = @import("std");

pub const ConnectionAuthorizationType = enum {
    basic,
    oauth_client_credentials,
    api_key,

    pub const json_field_names = .{
        .basic = "BASIC",
        .oauth_client_credentials = "OAUTH_CLIENT_CREDENTIALS",
        .api_key = "API_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .basic => "BASIC",
            .oauth_client_credentials => "OAUTH_CLIENT_CREDENTIALS",
            .api_key => "API_KEY",
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
