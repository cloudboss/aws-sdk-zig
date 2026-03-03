const std = @import("std");

pub const OptimizationJobStatus = enum {
    inprogress,
    completed,
    failed,
    starting,
    stopping,
    stopped,

    pub const json_field_names = .{
        .inprogress = "INPROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inprogress => "INPROGRESS",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .starting => "STARTING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
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
