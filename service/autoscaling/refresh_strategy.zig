const std = @import("std");

pub const RefreshStrategy = enum {
    rolling,
    replace_root_volume,

    pub const json_field_names = .{
        .rolling = "Rolling",
        .replace_root_volume = "ReplaceRootVolume",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rolling => "Rolling",
            .replace_root_volume => "ReplaceRootVolume",
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
