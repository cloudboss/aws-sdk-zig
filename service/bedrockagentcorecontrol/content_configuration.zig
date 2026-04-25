const ContentLevel = @import("content_level.zig").ContentLevel;
const ContentType = @import("content_type.zig").ContentType;

/// Defines what content to stream and at what level of detail.
pub const ContentConfiguration = struct {
    /// Level of detail for streamed content.
    level: ContentLevel = .metadata_only,

    /// Type of content to stream.
    @"type": ContentType,

    pub const json_field_names = .{
        .level = "level",
        .@"type" = "type",
    };
};
