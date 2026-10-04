const std = @import("std");

/// Mp2 Coding Mode
pub const Mp2CodingMode = enum {
    coding_mode_1_0,
    coding_mode_2_0,

    pub const json_field_names = .{
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_2_0 = "CODING_MODE_2_0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .coding_mode_1_0 => "CODING_MODE_1_0",
            .coding_mode_2_0 => "CODING_MODE_2_0",
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
