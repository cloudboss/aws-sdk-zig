const std = @import("std");

/// Enable Clear Lead DRM to reduce video startup latency by leaving the first
/// segment unencrypted while DRM license retrieval occurs in parallel. This
/// optimization allows immediate playback startup while maintaining content
/// protection for the remainder of the stream. When enabled, the first output
/// segment remains fully unencrypted, and encryption begins at the start of the
/// second segment. The HLS manifest will omit #EXT-X-KEY tags during the clear
/// segment and insert the first #EXT-X-KEY immediately before the first
/// encrypted fragment. This feature is supported exclusively for CMAF HLS
/// (fMP4) outputs and is compatible with all existing key provider integrations
/// (SPEKE v1, SPEKE v2, and Static Key encryption). Supported codecs: H.264,
/// H.265, and AV1 video codecs, and AAC audio codec. Choose Enabled to activate
/// Clear Lead DRM optimization. Choose Disabled to use standard encryption
/// where all segments are encrypted from the beginning.
pub const HlsClearLead = enum {
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
