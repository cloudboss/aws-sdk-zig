/// Specify whether MediaConvert generates images for trick play. Keep the
/// default value, None, to not generate any images. Choose Thumbnail to
/// generate tiled thumbnails. Choose Thumbnail and full frame to generate tiled
/// thumbnails and full-resolution images of single frames. When you enable
/// Write HLS manifest, MediaConvert creates a child manifest for each set of
/// images that you generate and adds corresponding entries to the parent
/// manifest. When you enable Write DASH manifest, MediaConvert adds an entry in
/// the .mpd manifest for each set of images that you generate. A common
/// application for these images is Roku trick mode. The thumbnails and
/// full-frame images that MediaConvert creates with this feature are compatible
/// with this Roku specification:
/// https://developer.roku.com/docs/developer-program/media-playback/trick-mode/hls-and-dash.md
pub const CmafImageBasedTrickPlay = enum {
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
};
