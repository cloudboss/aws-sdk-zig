const std = @import("std");

pub const UpgradeStep = enum {
    pre_upgrade_check,
    snapshot,
    upgrade,

    pub const json_field_names = .{
        .pre_upgrade_check = "PRE_UPGRADE_CHECK",
        .snapshot = "SNAPSHOT",
        .upgrade = "UPGRADE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pre_upgrade_check => "PRE_UPGRADE_CHECK",
            .snapshot => "SNAPSHOT",
            .upgrade => "UPGRADE",
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
