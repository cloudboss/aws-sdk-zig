const std = @import("std");

/// Allowed target statuses for the CompleteTrajectory operation.
pub const CompletionStatus = enum {
    /// Trajectory completed successfully; sealed and eligible for reward
    /// submission.
    ready,
    /// Trajectory failed; terminal state, no further processing.
    failed,

    pub const json_field_names = .{
        .ready = "ready",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "ready",
            .failed => "failed",
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
