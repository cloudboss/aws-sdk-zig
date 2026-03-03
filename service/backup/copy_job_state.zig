const std = @import("std");

pub const CopyJobState = enum {
    created,
    running,
    completed,
    failed,
    partial,

    pub const json_field_names = .{
        .created = "CREATED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .partial = "PARTIAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .partial => "PARTIAL",
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
