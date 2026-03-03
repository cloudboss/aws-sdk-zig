const std = @import("std");

pub const TaskStatus = enum {
    submitted,
    working,
    completed,
    canceled,
    failed,

    pub const json_field_names = .{
        .submitted = "submitted",
        .working = "working",
        .completed = "completed",
        .canceled = "canceled",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "submitted",
            .working => "working",
            .completed => "completed",
            .canceled => "canceled",
            .failed => "failed",
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
