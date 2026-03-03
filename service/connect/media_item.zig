const MediaType = @import("media_type.zig").MediaType;

/// Contains information about a media asset used in a workspace.
pub const MediaItem = struct {
    /// The source URL or data for the media asset.
    source: ?[]const u8 = null,

    /// The type of media. Valid values are: `IMAGE_LOGO_FAVICON` and
    /// `IMAGE_LOGO_HORIZONTAL`.
    @"type": ?MediaType = null,

    pub const json_field_names = .{
        .source = "Source",
        .@"type" = "Type",
    };
};
