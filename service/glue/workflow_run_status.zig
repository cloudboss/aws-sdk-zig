const std = @import("std");

pub const WorkflowRunStatus = enum {
    running,
    completed,
    stopping,
    stopped,
    @"error",

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .completed => "COMPLETED",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .@"error" => "ERROR",
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
