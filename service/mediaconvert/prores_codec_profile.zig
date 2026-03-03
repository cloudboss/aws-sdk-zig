const std = @import("std");

/// Use Profile to specify the type of Apple ProRes codec to use for this
/// output.
pub const ProresCodecProfile = enum {
    apple_prores_422,
    apple_prores_422_hq,
    apple_prores_422_lt,
    apple_prores_422_proxy,
    apple_prores_4444,
    apple_prores_4444_xq,

    pub const json_field_names = .{
        .apple_prores_422 = "APPLE_PRORES_422",
        .apple_prores_422_hq = "APPLE_PRORES_422_HQ",
        .apple_prores_422_lt = "APPLE_PRORES_422_LT",
        .apple_prores_422_proxy = "APPLE_PRORES_422_PROXY",
        .apple_prores_4444 = "APPLE_PRORES_4444",
        .apple_prores_4444_xq = "APPLE_PRORES_4444_XQ",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .apple_prores_422 => "APPLE_PRORES_422",
            .apple_prores_422_hq => "APPLE_PRORES_422_HQ",
            .apple_prores_422_lt => "APPLE_PRORES_422_LT",
            .apple_prores_422_proxy => "APPLE_PRORES_422_PROXY",
            .apple_prores_4444 => "APPLE_PRORES_4444",
            .apple_prores_4444_xq => "APPLE_PRORES_4444_XQ",
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
