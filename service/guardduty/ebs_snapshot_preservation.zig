const std = @import("std");

pub const EbsSnapshotPreservation = enum {
    no_retention,
    retention_with_finding,

    pub const json_field_names = .{
        .no_retention = "NO_RETENTION",
        .retention_with_finding = "RETENTION_WITH_FINDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_retention => "NO_RETENTION",
            .retention_with_finding => "RETENTION_WITH_FINDING",
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
