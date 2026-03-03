const std = @import("std");

pub const ProviderType = enum {
    bitbucket,
    github,
    github_enterprise_server,
    gitlab,
    gitlab_self_managed,

    pub const json_field_names = .{
        .bitbucket = "Bitbucket",
        .github = "GitHub",
        .github_enterprise_server = "GitHubEnterpriseServer",
        .gitlab = "GitLab",
        .gitlab_self_managed = "GitLabSelfManaged",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bitbucket => "Bitbucket",
            .github => "GitHub",
            .github_enterprise_server => "GitHubEnterpriseServer",
            .gitlab => "GitLab",
            .gitlab_self_managed => "GitLabSelfManaged",
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
