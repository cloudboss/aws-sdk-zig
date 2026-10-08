const PromotionalEmbeddedImage = @import("promotional_embedded_image.zig").PromotionalEmbeddedImage;
const PromotionalEmbeddedVideo = @import("promotional_embedded_video.zig").PromotionalEmbeddedVideo;

/// Embedded promotional media for a product, such as images or videos. Each
/// element contains exactly one media type.
pub const PromotionalMedia = union(enum) {
    embedded_image: ?PromotionalEmbeddedImage,
    embedded_video: ?PromotionalEmbeddedVideo,

    pub const json_field_names = .{
        .embedded_image = "embeddedImage",
        .embedded_video = "embeddedVideo",
    };
};
