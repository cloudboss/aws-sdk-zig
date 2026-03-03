const std = @import("std");

pub const BaseMapStyleType = enum {
    light_gray,
    dark_gray,
    street,
    imagery,

    pub const json_field_names = .{
        .light_gray = "LIGHT_GRAY",
        .dark_gray = "DARK_GRAY",
        .street = "STREET",
        .imagery = "IMAGERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .light_gray => "LIGHT_GRAY",
            .dark_gray => "DARK_GRAY",
            .street => "STREET",
            .imagery => "IMAGERY",
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
