const ImageCustomAction = @import("image_custom_action.zig").ImageCustomAction;
const ImageInteractionOptions = @import("image_interaction_options.zig").ImageInteractionOptions;
const SheetImageScalingConfiguration = @import("sheet_image_scaling_configuration.zig").SheetImageScalingConfiguration;
const SheetImageSource = @import("sheet_image_source.zig").SheetImageSource;
const SheetImageTooltipConfiguration = @import("sheet_image_tooltip_configuration.zig").SheetImageTooltipConfiguration;

/// An image that is located on a sheet.
pub const SheetImage = struct {
    /// A list of custom actions that are configured for an image.
    actions: ?[]const ImageCustomAction,

    /// The alt text for the image.
    image_content_alt_text: ?[]const u8,

    /// The general image interactions setup for an image.
    interactions: ?ImageInteractionOptions,

    /// Determines how the image is scaled.
    scaling: ?SheetImageScalingConfiguration,

    /// The ID of the sheet image.
    sheet_image_id: []const u8,

    /// The source of the image.
    source: SheetImageSource,

    /// The tooltip to be shown when hovering over the image.
    tooltip: ?SheetImageTooltipConfiguration,

    pub const json_field_names = .{
        .actions = "Actions",
        .image_content_alt_text = "ImageContentAltText",
        .interactions = "Interactions",
        .scaling = "Scaling",
        .sheet_image_id = "SheetImageId",
        .source = "Source",
        .tooltip = "Tooltip",
    };
};
