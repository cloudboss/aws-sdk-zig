const std = @import("std");

/// Use Deinterlacer to choose how the service will do deinterlacing. Default is
/// Deinterlace.
/// - Deinterlace converts interlaced to progressive.
/// - Inverse telecine converts Hard Telecine 29.97i to progressive 23.976p.
/// - Adaptive auto-detects and converts to progressive.
pub const DeinterlacerMode = enum {
    deinterlace,
    inverse_telecine,
    adaptive,

    pub const json_field_names = .{
        .deinterlace = "DEINTERLACE",
        .inverse_telecine = "INVERSE_TELECINE",
        .adaptive = "ADAPTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deinterlace => "DEINTERLACE",
            .inverse_telecine => "INVERSE_TELECINE",
            .adaptive => "ADAPTIVE",
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
