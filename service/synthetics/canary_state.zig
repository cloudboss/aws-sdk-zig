const std = @import("std");

pub const CanaryState = enum {
    creating,
    ready,
    starting,
    running,
    updating,
    stopping,
    stopped,
    @"error",
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .ready = "READY",
        .starting = "STARTING",
        .running = "RUNNING",
        .updating = "UPDATING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .ready => "READY",
            .starting => "STARTING",
            .running => "RUNNING",
            .updating => "UPDATING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .@"error" => "ERROR",
            .deleting => "DELETING",
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
