const std = @import("std");

pub const SimulationStatus = enum {
    unknown,
    starting,
    started,
    stopping,
    stopped,
    failed,
    deleting,
    deleted,
    snapshot_in_progress,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .starting = "STARTING",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .snapshot_in_progress = "SNAPSHOT_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown => "UNKNOWN",
            .starting => "STARTING",
            .started => "STARTED",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .failed => "FAILED",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .snapshot_in_progress => "SNAPSHOT_IN_PROGRESS",
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
