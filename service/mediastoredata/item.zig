const ItemType = @import("item_type.zig").ItemType;

/// A metadata entry for a folder or object.
pub const Item = struct {
    /// The length of the item in bytes.
    content_length: ?i64,

    /// The content type of the item.
    content_type: ?[]const u8,

    /// The ETag that represents a unique instance of the item.
    e_tag: ?[]const u8,

    /// The date and time that the item was last modified.
    last_modified: ?i64,

    /// The name of the item.
    name: ?[]const u8,

    /// The item type (folder or object).
    type: ?ItemType,

    pub const json_field_names = .{
        .content_length = "ContentLength",
        .content_type = "ContentType",
        .e_tag = "ETag",
        .last_modified = "LastModified",
        .name = "Name",
        .type = "Type",
    };
};
