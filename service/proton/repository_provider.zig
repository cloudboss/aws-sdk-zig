const std = @import("std");

pub const RepositoryProvider = enum {
    github,
    github_enterprise,
    bitbucket,

    pub const json_field_names = .{
        .github = "GITHUB",
        .github_enterprise = "GITHUB_ENTERPRISE",
        .bitbucket = "BITBUCKET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .github => "GITHUB",
            .github_enterprise => "GITHUB_ENTERPRISE",
            .bitbucket => "BITBUCKET",
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
