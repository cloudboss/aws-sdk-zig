const std = @import("std");

/// State of a campaign
pub const CampaignState = enum {
    /// Campaign is in initialized state
    initialized,
    /// Campaign is in running state
    running,
    /// Campaign is in paused state
    paused,
    /// Campaign is in stopped state
    stopped,
    /// Campaign is in failed state
    failed,
    /// Campaign is in completed state
    completed,

    pub const json_field_names = .{
        .initialized = "Initialized",
        .running = "Running",
        .paused = "Paused",
        .stopped = "Stopped",
        .failed = "Failed",
        .completed = "Completed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initialized => "Initialized",
            .running => "Running",
            .paused => "Paused",
            .stopped => "Stopped",
            .failed => "Failed",
            .completed => "Completed",
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
