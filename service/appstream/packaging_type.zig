const std = @import("std");

pub const PackagingType = enum {
    custom,
    appstream2,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .appstream2 = "APPSTREAM2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "CUSTOM",
            .appstream2 => "APPSTREAM2",
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
