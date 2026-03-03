const std = @import("std");

pub const LogType = enum {
    slow_log,
    engine_log,

    pub const json_field_names = .{
        .slow_log = "slow-log",
        .engine_log = "engine-log",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .slow_log => "slow-log",
            .engine_log => "engine-log",
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
