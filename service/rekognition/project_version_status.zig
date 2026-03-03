const std = @import("std");

pub const ProjectVersionStatus = enum {
    training_in_progress,
    training_completed,
    training_failed,
    starting,
    running,
    failed,
    stopping,
    stopped,
    deleting,
    copying_in_progress,
    copying_completed,
    copying_failed,
    deprecated,
    expired,

    pub const json_field_names = .{
        .training_in_progress = "TRAINING_IN_PROGRESS",
        .training_completed = "TRAINING_COMPLETED",
        .training_failed = "TRAINING_FAILED",
        .starting = "STARTING",
        .running = "RUNNING",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .deleting = "DELETING",
        .copying_in_progress = "COPYING_IN_PROGRESS",
        .copying_completed = "COPYING_COMPLETED",
        .copying_failed = "COPYING_FAILED",
        .deprecated = "DEPRECATED",
        .expired = "EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .training_in_progress => "TRAINING_IN_PROGRESS",
            .training_completed => "TRAINING_COMPLETED",
            .training_failed => "TRAINING_FAILED",
            .starting => "STARTING",
            .running => "RUNNING",
            .failed => "FAILED",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .deleting => "DELETING",
            .copying_in_progress => "COPYING_IN_PROGRESS",
            .copying_completed => "COPYING_COMPLETED",
            .copying_failed => "COPYING_FAILED",
            .deprecated => "DEPRECATED",
            .expired => "EXPIRED",
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
