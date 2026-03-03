const FreeFormLayoutElementBackgroundStyle = @import("free_form_layout_element_background_style.zig").FreeFormLayoutElementBackgroundStyle;
const FreeFormLayoutElementBorderStyle = @import("free_form_layout_element_border_style.zig").FreeFormLayoutElementBorderStyle;
const LayoutElementType = @import("layout_element_type.zig").LayoutElementType;
const LoadingAnimation = @import("loading_animation.zig").LoadingAnimation;
const SheetElementRenderingRule = @import("sheet_element_rendering_rule.zig").SheetElementRenderingRule;
const Visibility = @import("visibility.zig").Visibility;

/// An element within a free-form layout.
pub const FreeFormLayoutElement = struct {
    /// The background style configuration of a free-form layout element.
    background_style: ?FreeFormLayoutElementBackgroundStyle = null,

    /// The border radius of a free-form layout element.
    border_radius: ?[]const u8 = null,

    /// The border style configuration of a free-form layout element.
    border_style: ?FreeFormLayoutElementBorderStyle = null,

    /// A unique identifier for an element within a free-form layout.
    element_id: []const u8,

    /// The type of element.
    element_type: LayoutElementType,

    /// The height of an element within a free-form layout.
    height: []const u8,

    /// The loading animation configuration of a free-form layout element.
    loading_animation: ?LoadingAnimation = null,

    /// The padding of a free-form layout element.
    padding: ?[]const u8 = null,

    /// The rendering rules that determine when an element should be displayed
    /// within a free-form layout.
    rendering_rules: ?[]const SheetElementRenderingRule = null,

    /// The border style configuration of a free-form layout element. This border
    /// style is used when the element is selected.
    selected_border_style: ?FreeFormLayoutElementBorderStyle = null,

    /// The visibility of an element within a free-form layout.
    visibility: ?Visibility = null,

    /// The width of an element within a free-form layout.
    width: []const u8,

    /// The x-axis coordinate of the element.
    x_axis_location: []const u8,

    /// The y-axis coordinate of the element.
    y_axis_location: []const u8,

    pub const json_field_names = .{
        .background_style = "BackgroundStyle",
        .border_radius = "BorderRadius",
        .border_style = "BorderStyle",
        .element_id = "ElementId",
        .element_type = "ElementType",
        .height = "Height",
        .loading_animation = "LoadingAnimation",
        .padding = "Padding",
        .rendering_rules = "RenderingRules",
        .selected_border_style = "SelectedBorderStyle",
        .visibility = "Visibility",
        .width = "Width",
        .x_axis_location = "XAxisLocation",
        .y_axis_location = "YAxisLocation",
    };
};
