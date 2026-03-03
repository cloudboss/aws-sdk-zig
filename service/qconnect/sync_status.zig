const std = @import("std");

pub const SyncStatus = enum {
    sync_failed,
    syncing_in_progress,
    sync_success,
    create_in_progress,

    pub const json_field_names = .{
        .sync_failed = "SYNC_FAILED",
        .syncing_in_progress = "SYNCING_IN_PROGRESS",
        .sync_success = "SYNC_SUCCESS",
        .create_in_progress = "CREATE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sync_failed => "SYNC_FAILED",
            .syncing_in_progress => "SYNCING_IN_PROGRESS",
            .sync_success => "SYNC_SUCCESS",
            .create_in_progress => "CREATE_IN_PROGRESS",
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
