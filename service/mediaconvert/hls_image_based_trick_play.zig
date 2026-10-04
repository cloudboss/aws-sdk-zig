const std = @import("std");

/// Specify whether MediaConvert generates images for trick play. Keep the
/// default value, None, to not generate any images. Choose Thumbnail to
/// generate tiled thumbnails. Choose Thumbnail and full frame to generate tiled
/// thumbnails and full-resolution images of single frames. Choose Advanced to
/// customize thumbnail and tile settings for a single trick play variant.
/// Choose Variants to specify multiple trick play variants, each with its own
/// thumbnail and tile settings. MediaConvert creates a child manifest for each
/// set of images that you generate and adds corresponding entries to the parent
/// manifest. A common application for these images is Roku trick mode. The
/// thumbnails and full-frame images that MediaConvert creates with this feature
/// are compatible with this Roku specification:
/// https://developer.roku.com/docs/developer-program/media-playback/trick-mode/hls-and-dash.md
pub const HlsImageBasedTrickPlay = enum {
    none,
    thumbnail,
    thumbnail_and_fullframe,
    advanced,
    variants,

    pub const json_field_names = .{
        .none = "NONE",
        .thumbnail = "THUMBNAIL",
        .thumbnail_and_fullframe = "THUMBNAIL_AND_FULLFRAME",
        .advanced = "ADVANCED",
        .variants = "VARIANTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .thumbnail => "THUMBNAIL",
            .thumbnail_and_fullframe => "THUMBNAIL_AND_FULLFRAME",
            .advanced => "ADVANCED",
            .variants => "VARIANTS",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
