const std = @import("std");

pub const Compute = enum {
    value,
    standard,
    performance,
    power,
    graphics,
    powerpro,
    generalpurpose_4_xlarge,
    generalpurpose_8_xlarge,
    graphicspro,
    graphics_g4_dn,
    graphicspro_g4_dn,
    graphics_g6_xlarge,
    graphics_g6_2_xlarge,
    graphics_g6_4_xlarge,
    graphics_g6_8_xlarge,
    graphics_g6_16_xlarge,
    graphics_gr6_4_xlarge,
    graphics_gr6_8_xlarge,
    graphics_g6_f_large,
    graphics_g6_f_xlarge,
    graphics_g6_f_2_xlarge,
    graphics_g6_f_4_xlarge,
    graphics_gr6_f_4_xlarge,

    pub const json_field_names = .{
        .value = "VALUE",
        .standard = "STANDARD",
        .performance = "PERFORMANCE",
        .power = "POWER",
        .graphics = "GRAPHICS",
        .powerpro = "POWERPRO",
        .generalpurpose_4_xlarge = "GENERALPURPOSE_4XLARGE",
        .generalpurpose_8_xlarge = "GENERALPURPOSE_8XLARGE",
        .graphicspro = "GRAPHICSPRO",
        .graphics_g4_dn = "GRAPHICS_G4DN",
        .graphicspro_g4_dn = "GRAPHICSPRO_G4DN",
        .graphics_g6_xlarge = "GRAPHICS_G6_XLARGE",
        .graphics_g6_2_xlarge = "GRAPHICS_G6_2XLARGE",
        .graphics_g6_4_xlarge = "GRAPHICS_G6_4XLARGE",
        .graphics_g6_8_xlarge = "GRAPHICS_G6_8XLARGE",
        .graphics_g6_16_xlarge = "GRAPHICS_G6_16XLARGE",
        .graphics_gr6_4_xlarge = "GRAPHICS_GR6_4XLARGE",
        .graphics_gr6_8_xlarge = "GRAPHICS_GR6_8XLARGE",
        .graphics_g6_f_large = "GRAPHICS_G6F_LARGE",
        .graphics_g6_f_xlarge = "GRAPHICS_G6F_XLARGE",
        .graphics_g6_f_2_xlarge = "GRAPHICS_G6F_2XLARGE",
        .graphics_g6_f_4_xlarge = "GRAPHICS_G6F_4XLARGE",
        .graphics_gr6_f_4_xlarge = "GRAPHICS_GR6F_4XLARGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .value => "VALUE",
            .standard => "STANDARD",
            .performance => "PERFORMANCE",
            .power => "POWER",
            .graphics => "GRAPHICS",
            .powerpro => "POWERPRO",
            .generalpurpose_4_xlarge => "GENERALPURPOSE_4XLARGE",
            .generalpurpose_8_xlarge => "GENERALPURPOSE_8XLARGE",
            .graphicspro => "GRAPHICSPRO",
            .graphics_g4_dn => "GRAPHICS_G4DN",
            .graphicspro_g4_dn => "GRAPHICSPRO_G4DN",
            .graphics_g6_xlarge => "GRAPHICS_G6_XLARGE",
            .graphics_g6_2_xlarge => "GRAPHICS_G6_2XLARGE",
            .graphics_g6_4_xlarge => "GRAPHICS_G6_4XLARGE",
            .graphics_g6_8_xlarge => "GRAPHICS_G6_8XLARGE",
            .graphics_g6_16_xlarge => "GRAPHICS_G6_16XLARGE",
            .graphics_gr6_4_xlarge => "GRAPHICS_GR6_4XLARGE",
            .graphics_gr6_8_xlarge => "GRAPHICS_GR6_8XLARGE",
            .graphics_g6_f_large => "GRAPHICS_G6F_LARGE",
            .graphics_g6_f_xlarge => "GRAPHICS_G6F_XLARGE",
            .graphics_g6_f_2_xlarge => "GRAPHICS_G6F_2XLARGE",
            .graphics_g6_f_4_xlarge => "GRAPHICS_G6F_4XLARGE",
            .graphics_gr6_f_4_xlarge => "GRAPHICS_GR6F_4XLARGE",
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
