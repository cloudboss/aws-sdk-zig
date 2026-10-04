const std = @import("std");

/// Audio Normalization Algorithm
pub const AudioNormalizationAlgorithm = enum {
    itu_1770_1,
    itu_1770_2,
    itu_1770_3,
    itu_1770_4,

    pub const json_field_names = .{
        .itu_1770_1 = "ITU_1770_1",
        .itu_1770_2 = "ITU_1770_2",
        .itu_1770_3 = "ITU_1770_3",
        .itu_1770_4 = "ITU_1770_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .itu_1770_1 => "ITU_1770_1",
            .itu_1770_2 => "ITU_1770_2",
            .itu_1770_3 => "ITU_1770_3",
            .itu_1770_4 => "ITU_1770_4",
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
