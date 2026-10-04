const std = @import("std");

pub const ApplicationStatusCheckEnum = enum {
    passed,
    failed,
    initializing,
    insufficient_data,
    not_applicable,

    pub const json_field_names = .{
        .passed = "passed",
        .failed = "failed",
        .initializing = "initializing",
        .insufficient_data = "insufficient-data",
        .not_applicable = "not-applicable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passed => "passed",
            .failed => "failed",
            .initializing => "initializing",
            .insufficient_data => "insufficient-data",
            .not_applicable => "not-applicable",
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
