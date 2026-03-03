const std = @import("std");

pub const UpgradeStatus = enum {
    in_progress,
    succeeded,
    succeeded_with_issues,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .succeeded_with_issues = "SUCCEEDED_WITH_ISSUES",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
            .succeeded_with_issues => "SUCCEEDED_WITH_ISSUES",
            .failed => "FAILED",
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
