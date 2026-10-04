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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
