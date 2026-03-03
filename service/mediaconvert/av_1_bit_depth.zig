const std = @import("std");

/// Specify the Bit depth. You can choose 8-bit or 10-bit.
pub const Av1BitDepth = enum {
    bit_8,
    bit_10,

    pub const json_field_names = .{
        .bit_8 = "BIT_8",
        .bit_10 = "BIT_10",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bit_8 => "BIT_8",
            .bit_10 => "BIT_10",
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
