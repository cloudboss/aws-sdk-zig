const std = @import("std");

pub const TaskExecutionStatus = enum {
    queued,
    cancelling,
    launching,
    preparing,
    transferring,
    verifying,
    success,
    @"error",

    pub const json_field_names = .{
        .queued = "QUEUED",
        .cancelling = "CANCELLING",
        .launching = "LAUNCHING",
        .preparing = "PREPARING",
        .transferring = "TRANSFERRING",
        .verifying = "VERIFYING",
        .success = "SUCCESS",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .cancelling => "CANCELLING",
            .launching => "LAUNCHING",
            .preparing => "PREPARING",
            .transferring => "TRANSFERRING",
            .verifying => "VERIFYING",
            .success => "SUCCESS",
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
