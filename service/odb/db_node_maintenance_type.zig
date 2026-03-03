const std = @import("std");

pub const DbNodeMaintenanceType = enum {
    vmdb_reboot_migration,

    pub const json_field_names = .{
        .vmdb_reboot_migration = "VMDB_REBOOT_MIGRATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vmdb_reboot_migration => "VMDB_REBOOT_MIGRATION",
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
