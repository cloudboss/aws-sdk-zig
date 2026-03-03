const std = @import("std");

pub const PipelineExecutionStatus = enum {
    executing,
    stopping,
    stopped,
    failed,
    succeeded,

    pub const json_field_names = .{
        .executing = "Executing",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
        .succeeded = "Succeeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .executing => "Executing",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .failed => "Failed",
            .succeeded => "Succeeded",
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
