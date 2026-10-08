const std = @import("std");

pub const MultiAzDisasterRecoveryApproach = enum {
    active_active,
    hot_standby,
    warm_standby,
    pilot_light,
    backup_and_restore,

    pub const json_field_names = .{
        .active_active = "ACTIVE_ACTIVE",
        .hot_standby = "HOT_STANDBY",
        .warm_standby = "WARM_STANDBY",
        .pilot_light = "PILOT_LIGHT",
        .backup_and_restore = "BACKUP_AND_RESTORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active_active => "ACTIVE_ACTIVE",
            .hot_standby => "HOT_STANDBY",
            .warm_standby => "WARM_STANDBY",
            .pilot_light => "PILOT_LIGHT",
            .backup_and_restore => "BACKUP_AND_RESTORE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
