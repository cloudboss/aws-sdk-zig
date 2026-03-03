const std = @import("std");

pub const TableOptimizerEventType = enum {
    starting,
    completed,
    failed,
    in_progress,

    pub const json_field_names = .{
        .starting = "starting",
        .completed = "completed",
        .failed = "failed",
        .in_progress = "in_progress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starting => "starting",
            .completed => "completed",
            .failed => "failed",
            .in_progress => "in_progress",
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
