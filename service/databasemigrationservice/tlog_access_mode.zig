const std = @import("std");

pub const TlogAccessMode = enum {
    backup_only,
    prefer_backup,
    prefer_tlog,
    tlog_only,

    pub const json_field_names = .{
        .backup_only = "BackupOnly",
        .prefer_backup = "PreferBackup",
        .prefer_tlog = "PreferTlog",
        .tlog_only = "TlogOnly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .backup_only => "BackupOnly",
            .prefer_backup => "PreferBackup",
            .prefer_tlog => "PreferTlog",
            .tlog_only => "TlogOnly",
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
