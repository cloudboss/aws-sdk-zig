const std = @import("std");

pub const PipelineExecutionStatus = enum {
    cancelled,
    in_progress,
    stopped,
    stopping,
    succeeded,
    superseded,
    failed,

    pub const json_field_names = .{
        .cancelled = "Cancelled",
        .in_progress = "InProgress",
        .stopped = "Stopped",
        .stopping = "Stopping",
        .succeeded = "Succeeded",
        .superseded = "Superseded",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cancelled => "Cancelled",
            .in_progress => "InProgress",
            .stopped => "Stopped",
            .stopping => "Stopping",
            .succeeded => "Succeeded",
            .superseded => "Superseded",
            .failed => "Failed",
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
