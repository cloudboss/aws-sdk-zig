const std = @import("std");

/// Codec, 'MPEG2', 'AVC', 'HEVC', 'AUDIO', 'LINK', or 'AV1'
pub const ReservationCodec = enum {
    mpeg2,
    avc,
    hevc,
    audio,
    link,
    av1,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .avc = "AVC",
        .hevc = "HEVC",
        .audio = "AUDIO",
        .link = "LINK",
        .av1 = "AV1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mpeg2 => "MPEG2",
            .avc => "AVC",
            .hevc => "HEVC",
            .audio => "AUDIO",
            .link => "LINK",
            .av1 => "AV1",
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
