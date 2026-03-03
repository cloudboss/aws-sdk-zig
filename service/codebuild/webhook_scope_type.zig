const std = @import("std");

pub const WebhookScopeType = enum {
    github_organization,
    github_global,
    gitlab_group,

    pub const json_field_names = .{
        .github_organization = "GITHUB_ORGANIZATION",
        .github_global = "GITHUB_GLOBAL",
        .gitlab_group = "GITLAB_GROUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .github_organization => "GITHUB_ORGANIZATION",
            .github_global => "GITHUB_GLOBAL",
            .gitlab_group => "GITLAB_GROUP",
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
