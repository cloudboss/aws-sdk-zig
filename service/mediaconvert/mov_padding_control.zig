const std = @import("std");

/// Unless you need Omneon compatibility: Keep the default value, None. To make
/// this output compatible with Omneon: Choose Omneon. When you do, MediaConvert
/// increases the length of the 'elst' edit list atom. Note that this might
/// cause file rejections when a recipient of the output file doesn't expect
/// this extra padding.
pub const MovPaddingControl = enum {
    omneon,
    none,

    pub const json_field_names = .{
        .omneon = "OMNEON",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .omneon => "OMNEON",
            .none => "NONE",
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
