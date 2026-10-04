const std = @import("std");

/// The status of a notebook in Amazon SageMaker Unified Studio.
pub const NotebookStatus = enum {
    /// The notebook is active.
    active,
    /// The notebook is archived.
    archived,
    /// The notebook sync is in progress.
    sync_in_progress,
    /// The notebook sync failed.
    sync_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
        .sync_in_progress = "SYNC_IN_PROGRESS",
        .sync_failed = "SYNC_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .archived => "ARCHIVED",
            .sync_in_progress => "SYNC_IN_PROGRESS",
            .sync_failed => "SYNC_FAILED",
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
