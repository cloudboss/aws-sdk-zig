const std = @import("std");

/// Dolby AC-4 coding mode. Determines number of channels. Maps to
/// dlb_paec_ac4_bed_channel_config in the encoder implementation. -
/// CODING_MODE_2_0: 2.0 (stereo) - maps to DLB_PAEC_AC4_BED_CHANNEL_CONFIG_20 -
/// CODING_MODE_3_2_LFE: 5.1 surround - maps to
/// DLB_PAEC_AC4_BED_CHANNEL_CONFIG_51 - CODING_MODE_5_1_4: 5.1.4 immersive -
/// maps to DLB_PAEC_AC4_BED_CHANNEL_CONFIG_514
pub const Ac4CodingMode = enum {
    coding_mode_2_0,
    coding_mode_3_2_lfe,
    coding_mode_5_1_4,

    pub const json_field_names = .{
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_3_2_lfe = "CODING_MODE_3_2_LFE",
        .coding_mode_5_1_4 = "CODING_MODE_5_1_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .coding_mode_2_0 => "CODING_MODE_2_0",
            .coding_mode_3_2_lfe => "CODING_MODE_3_2_LFE",
            .coding_mode_5_1_4 => "CODING_MODE_5_1_4",
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
