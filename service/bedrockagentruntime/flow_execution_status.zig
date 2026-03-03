const std = @import("std");

pub const FlowExecutionStatus = enum {
    running,
    succeeded,
    failed,
    timed_out,
    aborted,

    pub const json_field_names = .{
        .running = "Running",
        .succeeded = "Succeeded",
        .failed = "Failed",
        .timed_out = "TimedOut",
        .aborted = "Aborted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "Running",
            .succeeded => "Succeeded",
            .failed => "Failed",
            .timed_out => "TimedOut",
            .aborted => "Aborted",
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
