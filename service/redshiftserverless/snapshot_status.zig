const std = @import("std");

pub const SnapshotStatus = enum {
    available,
    creating,
    deleted,
    cancelled,
    failed,
    copying,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleted = "DELETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .copying = "COPYING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .creating => "CREATING",
            .deleted => "DELETED",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
            .copying => "COPYING",
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
