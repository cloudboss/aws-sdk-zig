const std = @import("std");

pub const PreRollAdSequencingMode = enum {
    follow_ad_sequence,
    ignore_ad_sequence,

    pub const json_field_names = .{
        .follow_ad_sequence = "FOLLOW_AD_SEQUENCE",
        .ignore_ad_sequence = "IGNORE_AD_SEQUENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow_ad_sequence => "FOLLOW_AD_SEQUENCE",
            .ignore_ad_sequence => "IGNORE_AD_SEQUENCE",
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
