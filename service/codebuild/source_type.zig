const std = @import("std");

pub const SourceType = enum {
    codecommit,
    codepipeline,
    github,
    gitlab,
    gitlab_self_managed,
    s3,
    bitbucket,
    github_enterprise,
    no_source,

    pub const json_field_names = .{
        .codecommit = "CODECOMMIT",
        .codepipeline = "CODEPIPELINE",
        .github = "GITHUB",
        .gitlab = "GITLAB",
        .gitlab_self_managed = "GITLAB_SELF_MANAGED",
        .s3 = "S3",
        .bitbucket = "BITBUCKET",
        .github_enterprise = "GITHUB_ENTERPRISE",
        .no_source = "NO_SOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .codecommit => "CODECOMMIT",
            .codepipeline => "CODEPIPELINE",
            .github => "GITHUB",
            .gitlab => "GITLAB",
            .gitlab_self_managed => "GITLAB_SELF_MANAGED",
            .s3 => "S3",
            .bitbucket => "BITBUCKET",
            .github_enterprise => "GITHUB_ENTERPRISE",
            .no_source => "NO_SOURCE",
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
