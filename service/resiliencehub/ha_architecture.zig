const std = @import("std");

pub const HaArchitecture = enum {
    multi_site,
    warm_standby,
    pilot_light,
    backup_and_restore,
    no_recovery_plan,

    pub const json_field_names = .{
        .multi_site = "MultiSite",
        .warm_standby = "WarmStandby",
        .pilot_light = "PilotLight",
        .backup_and_restore = "BackupAndRestore",
        .no_recovery_plan = "NoRecoveryPlan",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_site => "MultiSite",
            .warm_standby => "WarmStandby",
            .pilot_light => "PilotLight",
            .backup_and_restore => "BackupAndRestore",
            .no_recovery_plan => "NoRecoveryPlan",
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
