const std = @import("std");

pub const DevEnvironmentStatus = enum {
    pending,
    running,
    starting,
    stopping,
    stopped,
    failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .running => "RUNNING",
            .starting => "STARTING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .failed => "FAILED",
            .deleting => "DELETING",
            .deleted => "DELETED",
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
