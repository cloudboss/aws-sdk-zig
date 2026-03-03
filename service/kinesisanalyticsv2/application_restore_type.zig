const std = @import("std");

pub const ApplicationRestoreType = enum {
    skip_restore_from_snapshot,
    restore_from_latest_snapshot,
    restore_from_custom_snapshot,

    pub const json_field_names = .{
        .skip_restore_from_snapshot = "SKIP_RESTORE_FROM_SNAPSHOT",
        .restore_from_latest_snapshot = "RESTORE_FROM_LATEST_SNAPSHOT",
        .restore_from_custom_snapshot = "RESTORE_FROM_CUSTOM_SNAPSHOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .skip_restore_from_snapshot => "SKIP_RESTORE_FROM_SNAPSHOT",
            .restore_from_latest_snapshot => "RESTORE_FROM_LATEST_SNAPSHOT",
            .restore_from_custom_snapshot => "RESTORE_FROM_CUSTOM_SNAPSHOT",
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
