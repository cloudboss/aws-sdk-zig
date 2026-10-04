const std = @import("std");

pub const Status = enum {
    building,
    ready,
    ready_basic_testing,
    failed,
    not_built,

    pub const json_field_names = .{
        .building = "BUILDING",
        .ready = "READY",
        .ready_basic_testing = "READY_BASIC_TESTING",
        .failed = "FAILED",
        .not_built = "NOT_BUILT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .building => "BUILDING",
            .ready => "READY",
            .ready_basic_testing => "READY_BASIC_TESTING",
            .failed => "FAILED",
            .not_built => "NOT_BUILT",
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
