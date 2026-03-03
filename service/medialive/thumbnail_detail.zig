const Thumbnail = @import("thumbnail.zig").Thumbnail;

/// Thumbnail details for one pipeline of a running channel.
pub const ThumbnailDetail = struct {
    /// Pipeline ID
    pipeline_id: ?[]const u8 = null,

    /// thumbnails of a single pipeline
    thumbnails: ?[]const Thumbnail = null,

    pub const json_field_names = .{
        .pipeline_id = "PipelineId",
        .thumbnails = "Thumbnails",
    };
};
