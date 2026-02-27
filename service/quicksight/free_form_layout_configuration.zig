const FreeFormLayoutCanvasSizeOptions = @import("free_form_layout_canvas_size_options.zig").FreeFormLayoutCanvasSizeOptions;
const FreeFormLayoutElement = @import("free_form_layout_element.zig").FreeFormLayoutElement;
const SheetLayoutGroup = @import("sheet_layout_group.zig").SheetLayoutGroup;

/// The configuration of a free-form layout.
pub const FreeFormLayoutConfiguration = struct {
    canvas_size_options: ?FreeFormLayoutCanvasSizeOptions,

    /// The elements that are included in a free-form layout.
    elements: []const FreeFormLayoutElement,

    /// The groups that are included in a free-form layout.
    groups: ?[]const SheetLayoutGroup,

    pub const json_field_names = .{
        .canvas_size_options = "CanvasSizeOptions",
        .elements = "Elements",
        .groups = "Groups",
    };
};
