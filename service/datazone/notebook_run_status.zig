const std = @import("std");

/// The status of a notebook run in Amazon DataZone.
pub const NotebookRunStatus = enum {
    /// The notebook run is queued.
    queued,
    /// The notebook run is starting.
    starting,
    /// The notebook run is running.
    running,
    /// The notebook run is stopping.
    stopping,
    /// The notebook run was stopped.
    stopped,
    /// The notebook run succeeded.
    succeeded,
    /// The notebook run failed.
    failed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .starting => "STARTING",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
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
