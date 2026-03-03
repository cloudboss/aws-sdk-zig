const std = @import("std");

/// Mpeg2 Gop Size Units
pub const Mpeg2GopSizeUnits = enum {
    frames,
    seconds,

    pub const json_field_names = .{
        .frames = "FRAMES",
        .seconds = "SECONDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .frames => "FRAMES",
            .seconds => "SECONDS",
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
