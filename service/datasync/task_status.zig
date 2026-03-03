const std = @import("std");

pub const TaskStatus = enum {
    available,
    creating,
    queued,
    running,
    unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .queued = "QUEUED",
        .running = "RUNNING",
        .unavailable = "UNAVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .creating => "CREATING",
            .queued => "QUEUED",
            .running => "RUNNING",
            .unavailable => "UNAVAILABLE",
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
