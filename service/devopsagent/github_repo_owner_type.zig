const std = @import("std");

/// Type of GitHub repository owner.
pub const GithubRepoOwnerType = enum {
    /// Repository owned by a GitHub organization.
    organization,
    /// Repository owned by an individual GitHub user.
    user,

    pub const json_field_names = .{
        .organization = "organization",
        .user = "user",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .organization => "organization",
            .user => "user",
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
