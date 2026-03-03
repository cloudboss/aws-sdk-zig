const std = @import("std");

/// Choose how the service meters the loudness of your audio.
pub const Eac3AtmosMeteringMode = enum {
    leq_a,
    itu_bs_1770_1,
    itu_bs_1770_2,
    itu_bs_1770_3,
    itu_bs_1770_4,

    pub const json_field_names = .{
        .leq_a = "LEQ_A",
        .itu_bs_1770_1 = "ITU_BS_1770_1",
        .itu_bs_1770_2 = "ITU_BS_1770_2",
        .itu_bs_1770_3 = "ITU_BS_1770_3",
        .itu_bs_1770_4 = "ITU_BS_1770_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .leq_a => "LEQ_A",
            .itu_bs_1770_1 => "ITU_BS_1770_1",
            .itu_bs_1770_2 => "ITU_BS_1770_2",
            .itu_bs_1770_3 => "ITU_BS_1770_3",
            .itu_bs_1770_4 => "ITU_BS_1770_4",
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
