const std = @import("std");

pub const NodeInstanceStatus = enum {
    running,
    @"error",
    not_available,
    paused,

    pub const json_field_names = .{
        .running = "RUNNING",
        .@"error" = "ERROR",
        .not_available = "NOT_AVAILABLE",
        .paused = "PAUSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .@"error" => "ERROR",
            .not_available => "NOT_AVAILABLE",
            .paused => "PAUSED",
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
