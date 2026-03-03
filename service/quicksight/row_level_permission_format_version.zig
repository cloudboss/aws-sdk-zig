const std = @import("std");

pub const RowLevelPermissionFormatVersion = enum {
    version_1,
    version_2,

    pub const json_field_names = .{
        .version_1 = "VERSION_1",
        .version_2 = "VERSION_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .version_1 => "VERSION_1",
            .version_2 => "VERSION_2",
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
