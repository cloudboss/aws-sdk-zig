const std = @import("std");

pub const VpcEncryptionControlState = enum {
    enforce_in_progress,
    monitor_in_progress,
    enforce_failed,
    monitor_failed,
    deleting,
    deleted,
    available,
    creating,
    delete_failed,

    pub const json_field_names = .{
        .enforce_in_progress = "enforce-in-progress",
        .monitor_in_progress = "monitor-in-progress",
        .enforce_failed = "enforce-failed",
        .monitor_failed = "monitor-failed",
        .deleting = "deleting",
        .deleted = "deleted",
        .available = "available",
        .creating = "creating",
        .delete_failed = "delete-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enforce_in_progress => "enforce-in-progress",
            .monitor_in_progress => "monitor-in-progress",
            .enforce_failed => "enforce-failed",
            .monitor_failed => "monitor-failed",
            .deleting => "deleting",
            .deleted => "deleted",
            .available => "available",
            .creating => "creating",
            .delete_failed => "delete-failed",
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
