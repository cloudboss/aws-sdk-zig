const std = @import("std");

pub const EnvironmentStatus = enum {
    @"error",
    creating,
    connecting,
    ready,
    stopping,
    stopped,
    deleting,

    pub const json_field_names = .{
        .@"error" = "error",
        .creating = "creating",
        .connecting = "connecting",
        .ready = "ready",
        .stopping = "stopping",
        .stopped = "stopped",
        .deleting = "deleting",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"error" => "error",
            .creating => "creating",
            .connecting => "connecting",
            .ready => "ready",
            .stopping => "stopping",
            .stopped => "stopped",
            .deleting => "deleting",
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
