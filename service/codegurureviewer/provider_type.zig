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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
