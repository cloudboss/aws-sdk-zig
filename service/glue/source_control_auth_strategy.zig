const std = @import("std");

pub const SourceControlAuthStrategy = enum {
    personal_access_token,
    aws_secrets_manager,

    pub const json_field_names = .{
        .personal_access_token = "PERSONAL_ACCESS_TOKEN",
        .aws_secrets_manager = "AWS_SECRETS_MANAGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .personal_access_token => "PERSONAL_ACCESS_TOKEN",
            .aws_secrets_manager => "AWS_SECRETS_MANAGER",
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
