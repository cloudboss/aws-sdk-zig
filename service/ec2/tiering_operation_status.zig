const std = @import("std");

pub const TieringOperationStatus = enum {
    archival_in_progress,
    archival_completed,
    archival_failed,
    temporary_restore_in_progress,
    temporary_restore_completed,
    temporary_restore_failed,
    permanent_restore_in_progress,
    permanent_restore_completed,
    permanent_restore_failed,

    pub const json_field_names = .{
        .archival_in_progress = "archival-in-progress",
        .archival_completed = "archival-completed",
        .archival_failed = "archival-failed",
        .temporary_restore_in_progress = "temporary-restore-in-progress",
        .temporary_restore_completed = "temporary-restore-completed",
        .temporary_restore_failed = "temporary-restore-failed",
        .permanent_restore_in_progress = "permanent-restore-in-progress",
        .permanent_restore_completed = "permanent-restore-completed",
        .permanent_restore_failed = "permanent-restore-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .archival_in_progress => "archival-in-progress",
            .archival_completed => "archival-completed",
            .archival_failed => "archival-failed",
            .temporary_restore_in_progress => "temporary-restore-in-progress",
            .temporary_restore_completed => "temporary-restore-completed",
            .temporary_restore_failed => "temporary-restore-failed",
            .permanent_restore_in_progress => "permanent-restore-in-progress",
            .permanent_restore_completed => "permanent-restore-completed",
            .permanent_restore_failed => "permanent-restore-failed",
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
