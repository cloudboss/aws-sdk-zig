const std = @import("std");

/// Specify whether MediaConvert generates HLS manifests while your job is
/// running or when your job is complete. To generate HLS manifests while your
/// job is running: Choose Enabled. Use if you want to play back your content as
/// soon as it's available. MediaConvert writes the parent and child manifests
/// after the first three media segments are written to your destination S3
/// bucket. It then writes new updated manifests after each additional segment
/// is written. The parent manifest includes the latest BANDWIDTH and
/// AVERAGE-BANDWIDTH attributes, and child manifests include the latest
/// available media segment. When your job completes, the final child playlists
/// include an EXT-X-ENDLIST tag. To generate HLS manifests only when your job
/// completes: Choose Disabled.
pub const HlsProgressiveWriteHlsManifest = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
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
