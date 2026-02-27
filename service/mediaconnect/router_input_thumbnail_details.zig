const RouterInputMessage = @import("router_input_message.zig").RouterInputMessage;

/// The details of a thumbnail associated with a router input, including the
/// thumbnail messages, the thumbnail image, the timecode, and the timestamp.
pub const RouterInputThumbnailDetails = struct {
    /// The thumbnail image, encoded as a Base64-encoded binary data object.
    thumbnail: ?[]const u8,

    /// The messages associated with the router input thumbnail.
    thumbnail_messages: []const RouterInputMessage,

    /// The timecode associated with the thumbnail.
    timecode: ?[]const u8,

    /// The timestamp associated with the thumbnail.
    timestamp: ?i64,

    pub const json_field_names = .{
        .thumbnail = "Thumbnail",
        .thumbnail_messages = "ThumbnailMessages",
        .timecode = "Timecode",
        .timestamp = "Timestamp",
    };
};
