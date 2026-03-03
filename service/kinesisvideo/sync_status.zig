const std = @import("std");

pub const SyncStatus = enum {
    syncing,
    acknowledged,
    in_sync,
    sync_failed,
    deleting,
    delete_failed,
    deleting_acknowledged,

    pub const json_field_names = .{
        .syncing = "SYNCING",
        .acknowledged = "ACKNOWLEDGED",
        .in_sync = "IN_SYNC",
        .sync_failed = "SYNC_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleting_acknowledged = "DELETING_ACKNOWLEDGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .syncing => "SYNCING",
            .acknowledged => "ACKNOWLEDGED",
            .in_sync => "IN_SYNC",
            .sync_failed => "SYNC_FAILED",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
            .deleting_acknowledged => "DELETING_ACKNOWLEDGED",
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
