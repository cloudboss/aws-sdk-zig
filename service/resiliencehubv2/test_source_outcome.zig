const std = @import("std");

/// The evaluation outcome of a test run success criteria source.
pub const TestSourceOutcome = enum {
    passed,
    failed,
    @"error",

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passed => "PASSED",
            .failed => "FAILED",
            .@"error" => "ERROR",
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
