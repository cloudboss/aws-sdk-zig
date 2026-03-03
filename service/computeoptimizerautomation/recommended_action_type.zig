const std = @import("std");

/// Recommended action type enumeration
pub const RecommendedActionType = enum {
    snapshot_and_delete_unattached_ebs_volume,
    upgrade_ebs_volume_type,

    pub const json_field_names = .{
        .snapshot_and_delete_unattached_ebs_volume = "SnapshotAndDeleteUnattachedEbsVolume",
        .upgrade_ebs_volume_type = "UpgradeEbsVolumeType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .snapshot_and_delete_unattached_ebs_volume => "SnapshotAndDeleteUnattachedEbsVolume",
            .upgrade_ebs_volume_type => "UpgradeEbsVolumeType",
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
