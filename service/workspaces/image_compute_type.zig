const std = @import("std");

pub const ImageComputeType = enum {
    base,
    graphics_g4_dn,
    graphics_g6,

    pub const json_field_names = .{
        .base = "BASE",
        .graphics_g4_dn = "GRAPHICS_G4DN",
        .graphics_g6 = "GRAPHICS_G6",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .base => "BASE",
            .graphics_g4_dn => "GRAPHICS_G4DN",
            .graphics_g6 => "GRAPHICS_G6",
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
