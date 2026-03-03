const std = @import("std");

pub const PullRequestBuildApproverRole = enum {
    github_read,
    github_triage,
    github_write,
    github_maintain,
    github_admin,
    gitlab_guest,
    gitlab_planner,
    gitlab_reporter,
    gitlab_developer,
    gitlab_maintainer,
    gitlab_owner,
    bitbucket_read,
    bitbucket_write,
    bitbucket_admin,

    pub const json_field_names = .{
        .github_read = "GITHUB_READ",
        .github_triage = "GITHUB_TRIAGE",
        .github_write = "GITHUB_WRITE",
        .github_maintain = "GITHUB_MAINTAIN",
        .github_admin = "GITHUB_ADMIN",
        .gitlab_guest = "GITLAB_GUEST",
        .gitlab_planner = "GITLAB_PLANNER",
        .gitlab_reporter = "GITLAB_REPORTER",
        .gitlab_developer = "GITLAB_DEVELOPER",
        .gitlab_maintainer = "GITLAB_MAINTAINER",
        .gitlab_owner = "GITLAB_OWNER",
        .bitbucket_read = "BITBUCKET_READ",
        .bitbucket_write = "BITBUCKET_WRITE",
        .bitbucket_admin = "BITBUCKET_ADMIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .github_read => "GITHUB_READ",
            .github_triage => "GITHUB_TRIAGE",
            .github_write => "GITHUB_WRITE",
            .github_maintain => "GITHUB_MAINTAIN",
            .github_admin => "GITHUB_ADMIN",
            .gitlab_guest => "GITLAB_GUEST",
            .gitlab_planner => "GITLAB_PLANNER",
            .gitlab_reporter => "GITLAB_REPORTER",
            .gitlab_developer => "GITLAB_DEVELOPER",
            .gitlab_maintainer => "GITLAB_MAINTAINER",
            .gitlab_owner => "GITLAB_OWNER",
            .bitbucket_read => "BITBUCKET_READ",
            .bitbucket_write => "BITBUCKET_WRITE",
            .bitbucket_admin => "BITBUCKET_ADMIN",
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
