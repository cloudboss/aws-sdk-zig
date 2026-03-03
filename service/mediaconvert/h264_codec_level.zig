const std = @import("std");

/// Specify an H.264 level that is consistent with your output video settings.
/// If you aren't sure what level to specify, choose Auto.
pub const H264CodecLevel = enum {
    auto,
    level_1,
    level_1_1,
    level_1_2,
    level_1_3,
    level_2,
    level_2_1,
    level_2_2,
    level_3,
    level_3_1,
    level_3_2,
    level_4,
    level_4_1,
    level_4_2,
    level_5,
    level_5_1,
    level_5_2,

    pub const json_field_names = .{
        .auto = "AUTO",
        .level_1 = "LEVEL_1",
        .level_1_1 = "LEVEL_1_1",
        .level_1_2 = "LEVEL_1_2",
        .level_1_3 = "LEVEL_1_3",
        .level_2 = "LEVEL_2",
        .level_2_1 = "LEVEL_2_1",
        .level_2_2 = "LEVEL_2_2",
        .level_3 = "LEVEL_3",
        .level_3_1 = "LEVEL_3_1",
        .level_3_2 = "LEVEL_3_2",
        .level_4 = "LEVEL_4",
        .level_4_1 = "LEVEL_4_1",
        .level_4_2 = "LEVEL_4_2",
        .level_5 = "LEVEL_5",
        .level_5_1 = "LEVEL_5_1",
        .level_5_2 = "LEVEL_5_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .level_1 => "LEVEL_1",
            .level_1_1 => "LEVEL_1_1",
            .level_1_2 => "LEVEL_1_2",
            .level_1_3 => "LEVEL_1_3",
            .level_2 => "LEVEL_2",
            .level_2_1 => "LEVEL_2_1",
            .level_2_2 => "LEVEL_2_2",
            .level_3 => "LEVEL_3",
            .level_3_1 => "LEVEL_3_1",
            .level_3_2 => "LEVEL_3_2",
            .level_4 => "LEVEL_4",
            .level_4_1 => "LEVEL_4_1",
            .level_4_2 => "LEVEL_4_2",
            .level_5 => "LEVEL_5",
            .level_5_1 => "LEVEL_5_1",
            .level_5_2 => "LEVEL_5_2",
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
