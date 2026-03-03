const std = @import("std");

/// Ac3 Coding Mode
pub const Ac3CodingMode = enum {
    coding_mode_1_0,
    coding_mode_1_1,
    coding_mode_2_0,
    coding_mode_3_2_lfe,

    pub const json_field_names = .{
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_1_1 = "CODING_MODE_1_1",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_3_2_lfe = "CODING_MODE_3_2_LFE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .coding_mode_1_0 => "CODING_MODE_1_0",
            .coding_mode_1_1 => "CODING_MODE_1_1",
            .coding_mode_2_0 => "CODING_MODE_2_0",
            .coding_mode_3_2_lfe => "CODING_MODE_3_2_LFE",
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
