const std = @import("std");

/// Specifies the file system's storage type.
pub const StorageType = enum {
    ssd,
    hdd,
    intelligent_tiering,

    pub const json_field_names = .{
        .ssd = "SSD",
        .hdd = "HDD",
        .intelligent_tiering = "INTELLIGENT_TIERING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ssd => "SSD",
            .hdd => "HDD",
            .intelligent_tiering => "INTELLIGENT_TIERING",
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
