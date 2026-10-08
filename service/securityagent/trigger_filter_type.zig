const std = @import("std");

/// A pull request value that a filter matches.
pub const TriggerFilterType = enum {
    /// The name of the pull request's target branch, for example `main`.
    target_branch,
    /// The labels on the pull request.
    label,

    pub const json_field_names = .{
        .target_branch = "TARGET_BRANCH",
        .label = "LABEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .target_branch => "TARGET_BRANCH",
            .label => "LABEL",
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
