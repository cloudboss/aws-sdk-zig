const std = @import("std");

/// A notebook run state that triggers a notification in Amazon SageMaker
/// Unified Studio.
pub const NotifyOnState = enum {
    /// Notify when the notebook run succeeds.
    succeeded,
    /// Notify when the notebook run fails.
    failed,
    /// Notify when the notebook run is stopped.
    stopped,
    /// Notify when the notebook run is queued.
    queued,
    /// Notify when the notebook run is starting.
    starting,
    /// Notify when the notebook run is running.
    running,
    /// Notify when the notebook run is stopping.
    stopping,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .queued = "QUEUED",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .stopped => "STOPPED",
            .queued => "QUEUED",
            .starting => "STARTING",
            .running => "RUNNING",
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
