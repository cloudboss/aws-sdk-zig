const SheetImageTooltipText = @import("sheet_image_tooltip_text.zig").SheetImageTooltipText;
const Visibility = @import("visibility.zig").Visibility;

/// The tooltip configuration for a sheet image.
pub const SheetImageTooltipConfiguration = struct {
    /// The text that appears in the tooltip.
    tooltip_text: ?SheetImageTooltipText = null,

    /// The visibility of the tooltip.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .tooltip_text = "TooltipText",
        .visibility = "Visibility",
    };
};
