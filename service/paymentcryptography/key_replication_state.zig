const std = @import("std");

/// Defines the replication state of a key
pub const KeyReplicationState = enum {
    in_progress,
    delete_in_progress,
    failed,
    synchronized,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .failed = "FAILED",
        .synchronized = "SYNCHRONIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .failed => "FAILED",
            .synchronized => "SYNCHRONIZED",
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
