const std = @import("std");

pub const CapabilitySyncStatus = enum {
    in_sync,
    out_of_sync,
    sync_failed,
    unknown,
    not_applicable,

    pub const json_field_names = .{
        .in_sync = "IN_SYNC",
        .out_of_sync = "OUT_OF_SYNC",
        .sync_failed = "SYNC_FAILED",
        .unknown = "UNKNOWN",
        .not_applicable = "NOT_APPLICABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_sync => "IN_SYNC",
            .out_of_sync => "OUT_OF_SYNC",
            .sync_failed => "SYNC_FAILED",
            .unknown => "UNKNOWN",
            .not_applicable => "NOT_APPLICABLE",
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
