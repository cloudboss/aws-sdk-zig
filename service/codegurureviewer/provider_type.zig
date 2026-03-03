const std = @import("std");

pub const ProviderType = enum {
    code_commit,
    git_hub,
    bitbucket,
    git_hub_enterprise_server,
    s3_bucket,

    pub const json_field_names = .{
        .code_commit = "CodeCommit",
        .git_hub = "GitHub",
        .bitbucket = "Bitbucket",
        .git_hub_enterprise_server = "GitHubEnterpriseServer",
        .s3_bucket = "S3Bucket",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .code_commit => "CodeCommit",
            .git_hub => "GitHub",
            .bitbucket => "Bitbucket",
            .git_hub_enterprise_server => "GitHubEnterpriseServer",
            .s3_bucket => "S3Bucket",
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
