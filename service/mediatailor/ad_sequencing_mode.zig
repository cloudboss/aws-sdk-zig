const std = @import("std");

pub const AdSequencingMode = enum {
    follow_ad_sequence,
    ignore_ad_sequence,
    follow_ad_sequence_only_live,
    follow_ad_sequence_only_vod,

    pub const json_field_names = .{
        .follow_ad_sequence = "FOLLOW_AD_SEQUENCE",
        .ignore_ad_sequence = "IGNORE_AD_SEQUENCE",
        .follow_ad_sequence_only_live = "FOLLOW_AD_SEQUENCE_ONLY_LIVE",
        .follow_ad_sequence_only_vod = "FOLLOW_AD_SEQUENCE_ONLY_VOD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow_ad_sequence => "FOLLOW_AD_SEQUENCE",
            .ignore_ad_sequence => "IGNORE_AD_SEQUENCE",
            .follow_ad_sequence_only_live => "FOLLOW_AD_SEQUENCE_ONLY_LIVE",
            .follow_ad_sequence_only_vod => "FOLLOW_AD_SEQUENCE_ONLY_VOD",
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
