const std = @import("std");

pub const ComponentStatus = enum {
    activated,
    starting,
    stopped,
    stopping,
    running,
    running_with_error,
    @"undefined",

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
        .running = "RUNNING",
        .running_with_error = "RUNNING_WITH_ERROR",
        .@"undefined" = "UNDEFINED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activated => "ACTIVATED",
            .starting => "STARTING",
            .stopped => "STOPPED",
            .stopping => "STOPPING",
            .running => "RUNNING",
            .running_with_error => "RUNNING_WITH_ERROR",
            .@"undefined" => "UNDEFINED",
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
