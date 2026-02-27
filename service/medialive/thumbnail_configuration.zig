const ThumbnailState = @import("thumbnail_state.zig").ThumbnailState;

/// Thumbnail Configuration
pub const ThumbnailConfiguration = struct {
    /// Enables the thumbnail feature. The feature generates thumbnails of the
    /// incoming video in each pipeline in the channel. AUTO turns the feature on,
    /// DISABLE turns the feature off.
    state: ThumbnailState,

    pub const json_field_names = .{
        .state = "State",
    };
};
