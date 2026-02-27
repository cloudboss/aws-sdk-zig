const ThumbnailStorageType = @import("thumbnail_storage_type.zig").ThumbnailStorageType;

/// An object representing a configuration of thumbnails for recorded video for
/// a Composition.
pub const CompositionThumbnailConfiguration = struct {
    /// Indicates the format in which thumbnails are recorded. `SEQUENTIAL` records
    /// all generated thumbnails in a serial manner, to the
    /// media/thumbnails/(width)x(height)
    /// directory, where (width) and (height) are the width and height of the
    /// thumbnail.
    /// `LATEST` saves the latest thumbnail in
    /// media/latest_thumbnail/(width)x(height)/thumb.jpg and overwrites it at the
    /// interval
    /// specified by `targetIntervalSeconds`. You can enable both
    /// `SEQUENTIAL` and `LATEST`. Default:
    /// `SEQUENTIAL`.
    storage: ?[]const ThumbnailStorageType,

    /// The targeted thumbnail-generation interval in seconds. Default: 60.
    target_interval_seconds: ?i32,

    pub const json_field_names = .{
        .storage = "storage",
        .target_interval_seconds = "targetIntervalSeconds",
    };
};
