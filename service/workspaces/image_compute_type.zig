const std = @import("std");

pub const ImageComputeType = enum {
    base,
    graphics_g4_dn,
    graphics_g6,
    graphics_g7,

    pub const json_field_names = .{
        .base = "BASE",
        .graphics_g4_dn = "GRAPHICS_G4DN",
        .graphics_g6 = "GRAPHICS_G6",
        .graphics_g7 = "GRAPHICS_G7",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .base => "BASE",
            .graphics_g4_dn => "GRAPHICS_G4DN",
            .graphics_g6 => "GRAPHICS_G6",
            .graphics_g7 => "GRAPHICS_G7",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
