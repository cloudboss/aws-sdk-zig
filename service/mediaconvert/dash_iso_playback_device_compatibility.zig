const std = @import("std");

/// This setting can improve the compatibility of your output with video players
/// on obsolete devices. It applies only to DASH outputs with DRM encryption.
/// Choose Unencrypted SEI only to correct problems with playback on older H.264
/// devices. Choose CENC v1 unencrypted headers to leave NAL unit headers and
/// slice headers unencrypted for H.265 outputs, improving compatibility with
/// strict HEVC decoders. Otherwise, keep the default setting CENC v1.
pub const DashIsoPlaybackDeviceCompatibility = enum {
    cenc_v1,
    unencrypted_sei,
    cenc_v1_unencrypted_headers,

    pub const json_field_names = .{
        .cenc_v1 = "CENC_V1",
        .unencrypted_sei = "UNENCRYPTED_SEI",
        .cenc_v1_unencrypted_headers = "CENC_V1_UNENCRYPTED_HEADERS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cenc_v1 => "CENC_V1",
            .unencrypted_sei => "UNENCRYPTED_SEI",
            .cenc_v1_unencrypted_headers => "CENC_V1_UNENCRYPTED_HEADERS",
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
