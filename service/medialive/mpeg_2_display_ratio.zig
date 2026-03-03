const std = @import("std");

/// Mpeg2 Display Ratio
pub const Mpeg2DisplayRatio = enum {
    displayratio16_x9,
    displayratio4_x3,

    pub const json_field_names = .{
        .displayratio16_x9 = "DISPLAYRATIO16X9",
        .displayratio4_x3 = "DISPLAYRATIO4X3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .displayratio16_x9 => "DISPLAYRATIO16X9",
            .displayratio4_x3 => "DISPLAYRATIO4X3",
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
