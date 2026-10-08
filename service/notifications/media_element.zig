const MediaElementType = @import("media_element_type.zig").MediaElementType;

/// Describes a media element.
pub const MediaElement = struct {
    /// The caption of the media.
    caption: []const u8,

    /// The unique ID for the media.
    media_id: []const u8,

    /// The type of media.
    type: MediaElementType,

    /// The URL of the media.
    url: []const u8,

    pub const json_field_names = .{
        .caption = "caption",
        .media_id = "mediaId",
        .type = "type",
        .url = "url",
    };
};
