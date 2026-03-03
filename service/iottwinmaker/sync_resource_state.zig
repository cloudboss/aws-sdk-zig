const std = @import("std");

pub const SyncResourceState = enum {
    initializing,
    processing,
    deleted,
    in_sync,
    @"error",

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .processing = "PROCESSING",
        .deleted = "DELETED",
        .in_sync = "IN_SYNC",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .processing => "PROCESSING",
            .deleted => "DELETED",
            .in_sync => "IN_SYNC",
            .@"error" => "ERROR",
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
