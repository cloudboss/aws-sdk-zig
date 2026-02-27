const GridLayoutElementBackgroundStyle = @import("grid_layout_element_background_style.zig").GridLayoutElementBackgroundStyle;
const GridLayoutElementBorderStyle = @import("grid_layout_element_border_style.zig").GridLayoutElementBorderStyle;
const LayoutElementType = @import("layout_element_type.zig").LayoutElementType;
const LoadingAnimation = @import("loading_animation.zig").LoadingAnimation;

/// An element within a grid layout.
pub const GridLayoutElement = struct {
    /// The background style configuration of a grid layout element.
    background_style: ?GridLayoutElementBackgroundStyle,

    /// The border radius of a grid layout element.
    border_radius: ?[]const u8,

    /// The border style configuration of a grid layout element.
    border_style: ?GridLayoutElementBorderStyle,

    /// The column index for the upper left corner of an element.
    column_index: ?i32,

    /// The width of a grid element expressed as a number of grid columns.
    column_span: i32,

    /// A unique identifier for an element within a grid layout.
    element_id: []const u8,

    /// The type of element.
    element_type: LayoutElementType,

    loading_animation: ?LoadingAnimation,

    /// The padding of a grid layout element.
    padding: ?[]const u8,

    /// The row index for the upper left corner of an element.
    row_index: ?i32,

    /// The height of a grid element expressed as a number of grid rows.
    row_span: i32,

    /// The border style configuration of a grid layout element. This border style
    /// is used when the element is selected.
    selected_border_style: ?GridLayoutElementBorderStyle,

    pub const json_field_names = .{
        .background_style = "BackgroundStyle",
        .border_radius = "BorderRadius",
        .border_style = "BorderStyle",
        .column_index = "ColumnIndex",
        .column_span = "ColumnSpan",
        .element_id = "ElementId",
        .element_type = "ElementType",
        .loading_animation = "LoadingAnimation",
        .padding = "Padding",
        .row_index = "RowIndex",
        .row_span = "RowSpan",
        .selected_border_style = "SelectedBorderStyle",
    };
};
