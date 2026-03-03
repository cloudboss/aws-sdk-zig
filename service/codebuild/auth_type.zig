const std = @import("std");

pub const AuthType = enum {
    oauth,
    basic_auth,
    personal_access_token,
    codeconnections,
    secrets_manager,

    pub const json_field_names = .{
        .oauth = "OAUTH",
        .basic_auth = "BASIC_AUTH",
        .personal_access_token = "PERSONAL_ACCESS_TOKEN",
        .codeconnections = "CODECONNECTIONS",
        .secrets_manager = "SECRETS_MANAGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .oauth => "OAUTH",
            .basic_auth => "BASIC_AUTH",
            .personal_access_token => "PERSONAL_ACCESS_TOKEN",
            .codeconnections => "CODECONNECTIONS",
            .secrets_manager => "SECRETS_MANAGER",
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
