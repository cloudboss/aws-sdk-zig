const std = @import("std");

pub const TaskStatus = enum {
    scheduled,
    started,
    in_progress,
    completed,
    @"error",
    skipped,
    cancelled,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .started = "STARTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .@"error" = "ERROR",
        .skipped = "SKIPPED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "SCHEDULED",
            .started => "STARTED",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
            .@"error" => "ERROR",
            .skipped => "SKIPPED",
            .cancelled => "CANCELLED",
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
