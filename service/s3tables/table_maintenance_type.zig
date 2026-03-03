const std = @import("std");

pub const TableMaintenanceType = enum {
    iceberg_compaction,
    iceberg_snapshot_management,

    pub const json_field_names = .{
        .iceberg_compaction = "icebergCompaction",
        .iceberg_snapshot_management = "icebergSnapshotManagement",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iceberg_compaction => "icebergCompaction",
            .iceberg_snapshot_management => "icebergSnapshotManagement",
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
