const std = @import("std");

pub const DatabaseStatus = enum {
    running,
    starting,
    stopped,
    warning,
    unknown,
    @"error",
    stopping,

    pub const json_field_names = .{
        .running = "RUNNING",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .warning = "WARNING",
        .unknown = "UNKNOWN",
        .@"error" = "ERROR",
        .stopping = "STOPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .starting => "STARTING",
            .stopped => "STOPPED",
            .warning => "WARNING",
            .unknown => "UNKNOWN",
            .@"error" => "ERROR",
            .stopping => "STOPPING",
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
