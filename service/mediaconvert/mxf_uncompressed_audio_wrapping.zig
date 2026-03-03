const std = @import("std");

/// Choose the audio frame wrapping mode for PCM tracks in MXF outputs. AUTO
/// (default): Uses codec-appropriate defaults - BWF for H.264/AVC, AES3 for
/// MPEG2/XDCAM. AES3: Use AES3 frame wrapping with SMPTE-compliant descriptors.
/// This setting only takes effect when the MXF profile is OP1a.
pub const MxfUncompressedAudioWrapping = enum {
    auto,
    aes3,

    pub const json_field_names = .{
        .auto = "AUTO",
        .aes3 = "AES3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .aes3 => "AES3",
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
