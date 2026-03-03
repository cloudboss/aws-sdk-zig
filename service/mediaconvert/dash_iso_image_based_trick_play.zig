const std = @import("std");

/// Specify whether MediaConvert generates images for trick play. Keep the
/// default value, None, to not generate any images. Choose Thumbnail to
/// generate tiled thumbnails. Choose Thumbnail and full frame to generate tiled
/// thumbnails and full-resolution images of single frames. MediaConvert adds an
/// entry in the .mpd manifest for each set of images that you generate. A
/// common application for these images is Roku trick mode. The thumbnails and
/// full-frame images that MediaConvert creates with this feature are compatible
/// with this Roku specification:
/// https://developer.roku.com/docs/developer-program/media-playback/trick-mode/hls-and-dash.md
pub const DashIsoImageBasedTrickPlay = enum {
    none,
    thumbnail,
    thumbnail_and_fullframe,
    advanced,

    pub const json_field_names = .{
        .none = "NONE",
        .thumbnail = "THUMBNAIL",
        .thumbnail_and_fullframe = "THUMBNAIL_AND_FULLFRAME",
        .advanced = "ADVANCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .thumbnail => "THUMBNAIL",
            .thumbnail_and_fullframe => "THUMBNAIL_AND_FULLFRAME",
            .advanced => "ADVANCED",
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
