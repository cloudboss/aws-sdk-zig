const std = @import("std");

/// Specify the text decoration for TTML captions output.
pub const TtmlTextDecoration = enum {
    none,
    underline,

    pub const json_field_names = .{
        .none = "NONE",
        .underline = "UNDERLINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .underline => "UNDERLINE",
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
