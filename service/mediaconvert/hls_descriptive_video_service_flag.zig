const std = @import("std");

/// Specify whether to flag this audio track as descriptive video service (DVS)
/// in your HLS parent manifest. When you choose Flag, MediaConvert includes the
/// parameter CHARACTERISTICS="public.accessibility.describes-video" in the
/// EXT-X-MEDIA entry for this track. When you keep the default choice, Don't
/// flag, MediaConvert leaves this parameter out. The DVS flag can help with
/// accessibility on Apple devices. For more information, see the Apple
/// documentation.
pub const HlsDescriptiveVideoServiceFlag = enum {
    dont_flag,
    flag,

    pub const json_field_names = .{
        .dont_flag = "DONT_FLAG",
        .flag = "FLAG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dont_flag => "DONT_FLAG",
            .flag => "FLAG",
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
