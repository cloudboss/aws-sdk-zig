const std = @import("std");

pub const CommandPluginStatus = enum {
    pending,
    in_progress,
    success,
    timed_out,
    cancelled,
    failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .success = "Success",
        .timed_out = "TimedOut",
        .cancelled = "Cancelled",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .in_progress => "InProgress",
            .success => "Success",
            .timed_out => "TimedOut",
            .cancelled => "Cancelled",
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
