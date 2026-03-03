const std = @import("std");

pub const EarthObservationJobStatus = enum {
    /// INITIALIZING
    initializing,
    /// IN_PROGRESS
    in_progress,
    /// STOPPING
    stopping,
    /// COMPLETED
    completed,
    /// STOPPED
    stopped,
    /// FAILED
    failed,
    /// DELETING
    deleting,
    /// DELETED
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .completed = "COMPLETED",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .in_progress => "IN_PROGRESS",
            .stopping => "STOPPING",
            .completed => "COMPLETED",
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
