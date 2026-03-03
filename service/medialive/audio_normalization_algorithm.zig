const std = @import("std");

/// Audio Normalization Algorithm
pub const AudioNormalizationAlgorithm = enum {
    itu_1770_1,
    itu_1770_2,

    pub const json_field_names = .{
        .itu_1770_1 = "ITU_1770_1",
        .itu_1770_2 = "ITU_1770_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .itu_1770_1 => "ITU_1770_1",
            .itu_1770_2 => "ITU_1770_2",
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
