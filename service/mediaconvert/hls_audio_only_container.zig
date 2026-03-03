const std = @import("std");

/// Use this setting only in audio-only outputs. Choose MPEG-2 Transport Stream
/// (M2TS) to create a file in an MPEG2-TS container. Keep the default value
/// Automatic to create a raw audio-only file with no container. Regardless of
/// the value that you specify here, if this output has video, the service will
/// place outputs into an MPEG2-TS container.
pub const HlsAudioOnlyContainer = enum {
    automatic,
    m2_ts,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .m2_ts = "M2TS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic => "AUTOMATIC",
            .m2_ts => "M2TS",
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
