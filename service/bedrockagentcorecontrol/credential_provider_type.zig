const std = @import("std");

pub const CredentialProviderType = enum {
    gateway_iam_role,
    oauth,
    api_key,

    pub const json_field_names = .{
        .gateway_iam_role = "GATEWAY_IAM_ROLE",
        .oauth = "OAUTH",
        .api_key = "API_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gateway_iam_role => "GATEWAY_IAM_ROLE",
            .oauth => "OAUTH",
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
