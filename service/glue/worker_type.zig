const std = @import("std");

pub const WorkerType = enum {
    standard,
    g_1_x,
    g_2_x,
    g_025_x,
    g_4_x,
    g_8_x,
    z_2_x,

    pub const json_field_names = .{
        .standard = "Standard",
        .g_1_x = "G.1X",
        .g_2_x = "G.2X",
        .g_025_x = "G.025X",
        .g_4_x = "G.4X",
        .g_8_x = "G.8X",
        .z_2_x = "Z.2X",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "Standard",
            .g_1_x => "G.1X",
            .g_2_x => "G.2X",
            .g_025_x => "G.025X",
            .g_4_x => "G.4X",
            .g_8_x => "G.8X",
            .z_2_x => "Z.2X",
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
