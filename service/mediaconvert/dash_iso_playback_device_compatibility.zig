const std = @import("std");

/// This setting can improve the compatibility of your output with video players
/// on obsolete devices. It applies only to DASH H.264 outputs with DRM
/// encryption. Choose Unencrypted SEI only to correct problems with playback on
/// older devices. Otherwise, keep the default setting CENC v1. If you choose
/// Unencrypted SEI, for that output, the service will exclude the access unit
/// delimiter and will leave the SEI NAL units unencrypted.
pub const DashIsoPlaybackDeviceCompatibility = enum {
    cenc_v1,
    unencrypted_sei,

    pub const json_field_names = .{
        .cenc_v1 = "CENC_V1",
        .unencrypted_sei = "UNENCRYPTED_SEI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cenc_v1 => "CENC_V1",
            .unencrypted_sei => "UNENCRYPTED_SEI",
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
