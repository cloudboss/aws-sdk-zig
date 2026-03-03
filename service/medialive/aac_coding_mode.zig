const std = @import("std");

/// Aac Coding Mode
pub const AacCodingMode = enum {
    ad_receiver_mix,
    coding_mode_1_0,
    coding_mode_1_1,
    coding_mode_2_0,
    coding_mode_5_1,

    pub const json_field_names = .{
        .ad_receiver_mix = "AD_RECEIVER_MIX",
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_1_1 = "CODING_MODE_1_1",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_5_1 = "CODING_MODE_5_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ad_receiver_mix => "AD_RECEIVER_MIX",
            .coding_mode_1_0 => "CODING_MODE_1_0",
            .coding_mode_1_1 => "CODING_MODE_1_1",
            .coding_mode_2_0 => "CODING_MODE_2_0",
            .coding_mode_5_1 => "CODING_MODE_5_1",
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
