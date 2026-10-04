const std = @import("std");

pub const PullRequestBuildCommentApproval = enum {
    disabled,
    all_pull_requests,
    fork_pull_requests,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .all_pull_requests = "ALL_PULL_REQUESTS",
        .fork_pull_requests = "FORK_PULL_REQUESTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .all_pull_requests => "ALL_PULL_REQUESTS",
            .fork_pull_requests => "FORK_PULL_REQUESTS",
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
