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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
