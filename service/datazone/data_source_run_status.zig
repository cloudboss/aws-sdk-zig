const std = @import("std");

pub const DataSourceRunStatus = enum {
    requested,
    running,
    failed,
    partially_succeeded,
    success,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .running = "RUNNING",
        .failed = "FAILED",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
        .success = "SUCCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requested => "REQUESTED",
            .running => "RUNNING",
            .failed => "FAILED",
            .partially_succeeded => "PARTIALLY_SUCCEEDED",
            .success => "SUCCESS",
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
