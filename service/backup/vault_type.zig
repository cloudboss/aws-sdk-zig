const std = @import("std");

pub const VaultType = enum {
    backup_vault,
    logically_air_gapped_backup_vault,
    restore_access_backup_vault,

    pub const json_field_names = .{
        .backup_vault = "BACKUP_VAULT",
        .logically_air_gapped_backup_vault = "LOGICALLY_AIR_GAPPED_BACKUP_VAULT",
        .restore_access_backup_vault = "RESTORE_ACCESS_BACKUP_VAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .backup_vault => "BACKUP_VAULT",
            .logically_air_gapped_backup_vault => "LOGICALLY_AIR_GAPPED_BACKUP_VAULT",
            .restore_access_backup_vault => "RESTORE_ACCESS_BACKUP_VAULT",
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
