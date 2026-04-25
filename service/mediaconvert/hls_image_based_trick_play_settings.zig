const HlsIntervalCadence = @import("hls_interval_cadence.zig").HlsIntervalCadence;

/// Tile and thumbnail settings applicable when imageBasedTrickPlay is ADVANCED
pub const HlsImageBasedTrickPlaySettings = struct {
    /// The cadence MediaConvert follows for generating thumbnails. If set to
    /// FOLLOW_IFRAME, MediaConvert generates thumbnails for each IDR frame in the
    /// output (matching the GOP cadence). If set to FOLLOW_CUSTOM, MediaConvert
    /// generates thumbnails according to the interval you specify in
    /// thumbnailInterval. If set to FOLLOW_SEGMENTATION, MediaConvert generates
    /// thumbnail playlist entries that align exactly with video segment boundaries.
    /// FOLLOW_SEGMENTATION requires 1x1 tiling.
    interval_cadence: ?HlsIntervalCadence = null,

    /// Height of each thumbnail within each tile image, in pixels. Leave blank to
    /// maintain aspect ratio with thumbnail width. If following the aspect ratio
    /// would lead to a total tile height greater than 4096, then the job will be
    /// rejected. Must be divisible by 2.
    thumbnail_height: ?i32 = null,

    /// Enter the interval, in seconds, that MediaConvert uses to generate
    /// thumbnails. If the interval you enter doesn't align with the output frame
    /// rate, MediaConvert automatically rounds the interval to align with the
    /// output frame rate. For example, if the output frame rate is 29.97 frames per
    /// second and you enter 5, MediaConvert uses a 150 frame interval to generate
    /// thumbnails.
    thumbnail_interval: ?f64 = null,

    /// Width of each thumbnail within each tile image, in pixels. Default is 312.
    /// Must be divisible by 8.
    thumbnail_width: ?i32 = null,

    /// Number of thumbnails in each column of a tile image. Set a value between 2
    /// and 2048. Must be divisible by 2.
    tile_height: ?i32 = null,

    /// Number of thumbnails in each row of a tile image. Set a value between 1 and
    /// 512.
    tile_width: ?i32 = null,

    pub const json_field_names = .{
        .interval_cadence = "IntervalCadence",
        .thumbnail_height = "ThumbnailHeight",
        .thumbnail_interval = "ThumbnailInterval",
        .thumbnail_width = "ThumbnailWidth",
        .tile_height = "TileHeight",
        .tile_width = "TileWidth",
    };
};
