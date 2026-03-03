const std = @import("std");

/// The type of storage connector.
pub const StorageConnectorType = enum {
    homefolders,
    google_drive,
    one_drive,

    pub const json_field_names = .{
        .homefolders = "HOMEFOLDERS",
        .google_drive = "GOOGLE_DRIVE",
        .one_drive = "ONE_DRIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .homefolders => "HOMEFOLDERS",
            .google_drive => "GOOGLE_DRIVE",
            .one_drive => "ONE_DRIVE",
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
