const std = @import("std");

/// The status of a training session.
pub const TrainingSessionStatus = enum {
    created,
    blocked,
    running,
    failed,
    scheduled,
    stopping,
    stopped,
    expired,
    deleting,
    deletion_failed,

    pub const json_field_names = .{
        .created = "Created",
        .blocked = "Blocked",
        .running = "Running",
        .failed = "Failed",
        .scheduled = "Scheduled",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .expired = "Expired",
        .deleting = "Deleting",
        .deletion_failed = "DeletionFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "Created",
            .blocked => "Blocked",
            .running => "Running",
            .failed => "Failed",
            .scheduled => "Scheduled",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .expired => "Expired",
            .deleting => "Deleting",
            .deletion_failed => "DeletionFailed",
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
