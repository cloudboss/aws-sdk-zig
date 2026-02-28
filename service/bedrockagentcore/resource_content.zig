const ResourceContentType = @import("resource_content_type.zig").ResourceContentType;

/// Contains information about resource content.
pub const ResourceContent = struct {
    /// The binary resource content.
    blob: ?[]const u8,

    /// The MIME type of the resource content.
    mime_type: ?[]const u8,

    /// The text resource content.
    text: ?[]const u8,

    /// The type of resource content.
    @"type": ResourceContentType,

    /// The URI of the resource content.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .blob = "blob",
        .mime_type = "mimeType",
        .text = "text",
        .@"type" = "type",
        .uri = "uri",
    };
};
