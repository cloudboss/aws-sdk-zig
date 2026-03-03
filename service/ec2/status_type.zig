const std = @import("std");

pub const StatusType = enum {
    passed,
    failed,
    insufficient_data,
    initializing,

    pub const json_field_names = .{
        .passed = "passed",
        .failed = "failed",
        .insufficient_data = "insufficient-data",
        .initializing = "initializing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passed => "passed",
            .failed => "failed",
            .insufficient_data => "insufficient-data",
            .initializing => "initializing",
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
