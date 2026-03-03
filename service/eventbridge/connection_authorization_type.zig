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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
