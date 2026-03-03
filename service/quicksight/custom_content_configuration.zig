const CustomContentType = @import("custom_content_type.zig").CustomContentType;
const CustomContentImageScalingConfiguration = @import("custom_content_image_scaling_configuration.zig").CustomContentImageScalingConfiguration;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;

/// The configuration of a `CustomContentVisual`.
pub const CustomContentConfiguration = struct {
    /// The content type of the custom content visual. You can use this to have the
    /// visual render as an image.
    content_type: ?CustomContentType = null,

    /// The input URL that links to the custom content that you want in the custom
    /// visual.
    content_url: ?[]const u8 = null,

    /// The sizing options for the size of the custom content visual. This structure
    /// is required when the `ContentType` of the visual is `'IMAGE'`.
    image_scaling: ?CustomContentImageScalingConfiguration = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .content_url = "ContentUrl",
        .image_scaling = "ImageScaling",
        .interactions = "Interactions",
    };
};
