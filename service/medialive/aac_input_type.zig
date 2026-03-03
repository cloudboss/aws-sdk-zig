const std = @import("std");

/// Aac Input Type
pub const AacInputType = enum {
    broadcaster_mixed_ad,
    normal,

    pub const json_field_names = .{
        .broadcaster_mixed_ad = "BROADCASTER_MIXED_AD",
        .normal = "NORMAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .broadcaster_mixed_ad => "BROADCASTER_MIXED_AD",
            .normal => "NORMAL",
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
