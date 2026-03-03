const std = @import("std");

/// Use this setting only in DASH output groups that include sidecar TTML, IMSC
/// or WEBVTT captions. You specify sidecar captions in a separate output from
/// your audio and video. Choose Raw for captions in a single XML file in a raw
/// container. Choose Fragmented MPEG-4 for captions in XML format contained
/// within fragmented MP4 files. This set of fragmented MP4 files is separate
/// from your video and audio fragmented MP4 files.
pub const MpdCaptionContainerType = enum {
    raw,
    fragmented_mp4,

    pub const json_field_names = .{
        .raw = "RAW",
        .fragmented_mp4 = "FRAGMENTED_MP4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .raw => "RAW",
            .fragmented_mp4 => "FRAGMENTED_MP4",
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
