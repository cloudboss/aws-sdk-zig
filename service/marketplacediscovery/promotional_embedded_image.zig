/// An embedded promotional image for a product.
pub const PromotionalEmbeddedImage = struct {
    /// An optional description of the image.
    description: ?[]const u8 = null,

    /// The title displayed when hovering over the image.
    title: []const u8,

    /// The URL of the image file.
    url: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .title = "title",
        .url = "url",
    };
};
