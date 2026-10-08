const std = @import("std");

/// Type of GitLab access token.
pub const GitLabTokenType = enum {
    /// Personal access token
    personal,
    /// Group access token
    group,

    pub const json_field_names = .{
        .personal = "personal",
        .group = "group",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .personal => "personal",
            .group => "group",
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
