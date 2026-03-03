const std = @import("std");

pub const AutoSnapshotStatus = enum {
    success,
    failed,
    in_progress,
    not_found,

    pub const json_field_names = .{
        .success = "Success",
        .failed = "Failed",
        .in_progress = "InProgress",
        .not_found = "NotFound",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "Success",
            .failed => "Failed",
            .in_progress => "InProgress",
            .not_found => "NotFound",
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
