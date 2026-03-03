const std = @import("std");

/// H264 Syntax
pub const H264Syntax = enum {
    default,
    rp2027,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .rp2027 = "RP2027",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .rp2027 => "RP2027",
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
