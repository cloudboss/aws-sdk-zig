const std = @import("std");

/// Eac3 Atmos Coding Mode
pub const Eac3AtmosCodingMode = enum {
    coding_mode_5_1_4,
    coding_mode_7_1_4,
    coding_mode_9_1_6,

    pub const json_field_names = .{
        .coding_mode_5_1_4 = "CODING_MODE_5_1_4",
        .coding_mode_7_1_4 = "CODING_MODE_7_1_4",
        .coding_mode_9_1_6 = "CODING_MODE_9_1_6",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .coding_mode_5_1_4 => "CODING_MODE_5_1_4",
            .coding_mode_7_1_4 => "CODING_MODE_7_1_4",
            .coding_mode_9_1_6 => "CODING_MODE_9_1_6",
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
