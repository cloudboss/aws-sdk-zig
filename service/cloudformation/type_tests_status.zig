const std = @import("std");

pub const TypeTestsStatus = enum {
    passed,
    failed,
    in_progress,
    not_tested,

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .not_tested = "NOT_TESTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passed => "PASSED",
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .not_tested => "NOT_TESTED",
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
