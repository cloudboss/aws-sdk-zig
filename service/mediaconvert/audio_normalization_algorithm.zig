const std = @import("std");

/// Choose one of the following audio normalization algorithms: ITU-R BS.1770-1:
/// Ungated loudness. A measurement of ungated average loudness for an entire
/// piece of content, suitable for measurement of short-form content under ATSC
/// recommendation A/85. Supports up to 5.1 audio channels. ITU-R BS.1770-2:
/// Gated loudness. A measurement of gated average loudness compliant with the
/// requirements of EBU-R128. Supports up to 5.1 audio channels. ITU-R
/// BS.1770-3: Modified peak. The same loudness measurement algorithm as 1770-2,
/// with an updated true peak measurement. ITU-R BS.1770-4: Higher channel
/// count. Allows for more audio channels than the other algorithms, including
/// configurations such as 7.1.
pub const AudioNormalizationAlgorithm = enum {
    itu_bs_1770_1,
    itu_bs_1770_2,
    itu_bs_1770_3,
    itu_bs_1770_4,

    pub const json_field_names = .{
        .itu_bs_1770_1 = "ITU_BS_1770_1",
        .itu_bs_1770_2 = "ITU_BS_1770_2",
        .itu_bs_1770_3 = "ITU_BS_1770_3",
        .itu_bs_1770_4 = "ITU_BS_1770_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
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
