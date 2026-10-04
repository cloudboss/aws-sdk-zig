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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
