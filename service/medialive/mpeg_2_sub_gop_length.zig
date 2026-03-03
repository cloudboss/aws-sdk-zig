const std = @import("std");

/// Mpeg2 Sub Gop Length
pub const Mpeg2SubGopLength = enum {
    dynamic,
    fixed,

    pub const json_field_names = .{
        .dynamic = "DYNAMIC",
        .fixed = "FIXED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dynamic => "DYNAMIC",
            .fixed => "FIXED",
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
