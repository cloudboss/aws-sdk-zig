const ResourceContent = @import("resource_content.zig").ResourceContent;
const ContentBlockType = @import("content_block_type.zig").ContentBlockType;

/// A block of content in a response.
pub const ContentBlock = struct {
    /// The binary data content of the block.
    data: ?[]const u8 = null,

    /// The description of the content block.
    description: ?[]const u8 = null,

    /// The MIME type of the content.
    mime_type: ?[]const u8 = null,

    /// The name of the content block.
    name: ?[]const u8 = null,

    /// The resource associated with the content block.
    resource: ?ResourceContent = null,

    /// The size of the content in bytes.
    size: ?i64 = null,

    /// The text content of the block.
    text: ?[]const u8 = null,

    /// The type of content in the block.
    @"type": ContentBlockType,

    /// The URI of the content.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
        .description = "description",
        .mime_type = "mimeType",
        .name = "name",
        .resource = "resource",
        .size = "size",
        .text = "text",
        .@"type" = "type",
        .uri = "uri",
    };
};
