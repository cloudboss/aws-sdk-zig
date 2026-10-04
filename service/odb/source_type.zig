const std = @import("std");

pub const SourceType = enum {
    none,
    database,
    backup_from_id,
    backup_from_timestamp,
    cross_region_dataguard,
    cross_region_disaster_recovery,
    clone_to_refreshable,

    pub const json_field_names = .{
        .none = "NONE",
        .database = "DATABASE",
        .backup_from_id = "BACKUP_FROM_ID",
        .backup_from_timestamp = "BACKUP_FROM_TIMESTAMP",
        .cross_region_dataguard = "CROSS_REGION_DATAGUARD",
        .cross_region_disaster_recovery = "CROSS_REGION_DISASTER_RECOVERY",
        .clone_to_refreshable = "CLONE_TO_REFRESHABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .database => "DATABASE",
            .backup_from_id => "BACKUP_FROM_ID",
            .backup_from_timestamp => "BACKUP_FROM_TIMESTAMP",
            .cross_region_dataguard => "CROSS_REGION_DATAGUARD",
            .cross_region_disaster_recovery => "CROSS_REGION_DISASTER_RECOVERY",
            .clone_to_refreshable => "CLONE_TO_REFRESHABLE",
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
