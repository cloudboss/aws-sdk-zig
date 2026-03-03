const std = @import("std");

/// H264 Level
pub const H264Level = enum {
    h264_level_1,
    h264_level_1_1,
    h264_level_1_2,
    h264_level_1_3,
    h264_level_2,
    h264_level_2_1,
    h264_level_2_2,
    h264_level_3,
    h264_level_3_1,
    h264_level_3_2,
    h264_level_4,
    h264_level_4_1,
    h264_level_4_2,
    h264_level_5,
    h264_level_5_1,
    h264_level_5_2,
    h264_level_auto,

    pub const json_field_names = .{
        .h264_level_1 = "H264_LEVEL_1",
        .h264_level_1_1 = "H264_LEVEL_1_1",
        .h264_level_1_2 = "H264_LEVEL_1_2",
        .h264_level_1_3 = "H264_LEVEL_1_3",
        .h264_level_2 = "H264_LEVEL_2",
        .h264_level_2_1 = "H264_LEVEL_2_1",
        .h264_level_2_2 = "H264_LEVEL_2_2",
        .h264_level_3 = "H264_LEVEL_3",
        .h264_level_3_1 = "H264_LEVEL_3_1",
        .h264_level_3_2 = "H264_LEVEL_3_2",
        .h264_level_4 = "H264_LEVEL_4",
        .h264_level_4_1 = "H264_LEVEL_4_1",
        .h264_level_4_2 = "H264_LEVEL_4_2",
        .h264_level_5 = "H264_LEVEL_5",
        .h264_level_5_1 = "H264_LEVEL_5_1",
        .h264_level_5_2 = "H264_LEVEL_5_2",
        .h264_level_auto = "H264_LEVEL_AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .h264_level_1 => "H264_LEVEL_1",
            .h264_level_1_1 => "H264_LEVEL_1_1",
            .h264_level_1_2 => "H264_LEVEL_1_2",
            .h264_level_1_3 => "H264_LEVEL_1_3",
            .h264_level_2 => "H264_LEVEL_2",
            .h264_level_2_1 => "H264_LEVEL_2_1",
            .h264_level_2_2 => "H264_LEVEL_2_2",
            .h264_level_3 => "H264_LEVEL_3",
            .h264_level_3_1 => "H264_LEVEL_3_1",
            .h264_level_3_2 => "H264_LEVEL_3_2",
            .h264_level_4 => "H264_LEVEL_4",
            .h264_level_4_1 => "H264_LEVEL_4_1",
            .h264_level_4_2 => "H264_LEVEL_4_2",
            .h264_level_5 => "H264_LEVEL_5",
            .h264_level_5_1 => "H264_LEVEL_5_1",
            .h264_level_5_2 => "H264_LEVEL_5_2",
            .h264_level_auto => "H264_LEVEL_AUTO",
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
