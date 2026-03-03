const std = @import("std");

/// Wav Coding Mode
pub const WavCodingMode = enum {
    coding_mode_1_0,
    coding_mode_2_0,
    coding_mode_4_0,
    coding_mode_8_0,

    pub const json_field_names = .{
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_4_0 = "CODING_MODE_4_0",
        .coding_mode_8_0 = "CODING_MODE_8_0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .coding_mode_1_0 => "CODING_MODE_1_0",
            .coding_mode_2_0 => "CODING_MODE_2_0",
            .coding_mode_4_0 => "CODING_MODE_4_0",
            .coding_mode_8_0 => "CODING_MODE_8_0",
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
