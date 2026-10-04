const std = @import("std");

pub const DataGuardRole = enum {
    primary,
    standby,
    disabled_standby,
    backup_copy,
    snapshot_standby,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .standby = "STANDBY",
        .disabled_standby = "DISABLED_STANDBY",
        .backup_copy = "BACKUP_COPY",
        .snapshot_standby = "SNAPSHOT_STANDBY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary => "PRIMARY",
            .standby => "STANDBY",
            .disabled_standby => "DISABLED_STANDBY",
            .backup_copy => "BACKUP_COPY",
            .snapshot_standby => "SNAPSHOT_STANDBY",
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
