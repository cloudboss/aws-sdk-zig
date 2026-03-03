const std = @import("std");

pub const WorkspaceImageIngestionProcess = enum {
    byol_regular,
    byol_graphics,
    byol_graphicspro,
    byol_graphics_g4_dn,
    byol_regular_wsp,
    byol_graphics_g4_dn_wsp,
    byol_regular_byop,
    byol_graphics_g4_dn_byop,

    pub const json_field_names = .{
        .byol_regular = "BYOL_REGULAR",
        .byol_graphics = "BYOL_GRAPHICS",
        .byol_graphicspro = "BYOL_GRAPHICSPRO",
        .byol_graphics_g4_dn = "BYOL_GRAPHICS_G4DN",
        .byol_regular_wsp = "BYOL_REGULAR_WSP",
        .byol_graphics_g4_dn_wsp = "BYOL_GRAPHICS_G4DN_WSP",
        .byol_regular_byop = "BYOL_REGULAR_BYOP",
        .byol_graphics_g4_dn_byop = "BYOL_GRAPHICS_G4DN_BYOP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .byol_regular => "BYOL_REGULAR",
            .byol_graphics => "BYOL_GRAPHICS",
            .byol_graphicspro => "BYOL_GRAPHICSPRO",
            .byol_graphics_g4_dn => "BYOL_GRAPHICS_G4DN",
            .byol_regular_wsp => "BYOL_REGULAR_WSP",
            .byol_graphics_g4_dn_wsp => "BYOL_GRAPHICS_G4DN_WSP",
            .byol_regular_byop => "BYOL_REGULAR_BYOP",
            .byol_graphics_g4_dn_byop => "BYOL_GRAPHICS_G4DN_BYOP",
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
