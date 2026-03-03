const SheetContentType = @import("sheet_content_type.zig").SheetContentType;
const VisualCustomActionDefaults = @import("visual_custom_action_defaults.zig").VisualCustomActionDefaults;
const FilterControl = @import("filter_control.zig").FilterControl;
const SheetImage = @import("sheet_image.zig").SheetImage;
const Layout = @import("layout.zig").Layout;
const ParameterControl = @import("parameter_control.zig").ParameterControl;
const SheetControlLayout = @import("sheet_control_layout.zig").SheetControlLayout;
const SheetTextBox = @import("sheet_text_box.zig").SheetTextBox;
const Visual = @import("visual.zig").Visual;

/// A sheet is an object that contains a set of visuals that
/// are viewed together on one page in a paginated report. Every analysis and
/// dashboard must contain at least one sheet.
pub const SheetDefinition = struct {
    /// The layout content type of the sheet. Choose one of the following options:
    ///
    /// * `PAGINATED`: Creates a sheet for a paginated report.
    ///
    /// * `INTERACTIVE`: Creates a sheet for an interactive dashboard.
    content_type: ?SheetContentType = null,

    /// A list of visual custom actions for the sheet.
    custom_action_defaults: ?VisualCustomActionDefaults = null,

    /// A description of the sheet.
    description: ?[]const u8 = null,

    /// The list of filter controls that are on a sheet.
    ///
    /// For more information, see [Adding filter controls to analysis
    /// sheets](https://docs.aws.amazon.com/quicksight/latest/user/filter-controls.html) in the *Amazon Quick Suite User Guide*.
    filter_controls: ?[]const FilterControl = null,

    /// A list of images on a sheet.
    images: ?[]const SheetImage = null,

    /// Layouts define how the components of a sheet are arranged.
    ///
    /// For more information, see [Types of
    /// layout](https://docs.aws.amazon.com/quicksight/latest/user/types-of-layout.html) in the *Amazon Quick Suite User Guide*.
    layouts: ?[]const Layout = null,

    /// The name of the sheet. This name is displayed on the sheet's tab in the
    /// Quick Suite
    /// console.
    name: ?[]const u8 = null,

    /// The list of parameter controls that are on a sheet.
    ///
    /// For more information, see [Using a Control with a Parameter in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/parameters-controls.html) in the *Amazon Quick Suite User Guide*.
    parameter_controls: ?[]const ParameterControl = null,

    /// The control layouts of the sheet.
    sheet_control_layouts: ?[]const SheetControlLayout = null,

    /// The unique identifier of a sheet.
    sheet_id: []const u8,

    /// The text boxes that are on a sheet.
    text_boxes: ?[]const SheetTextBox = null,

    /// The title of the sheet.
    title: ?[]const u8 = null,

    /// A list of the visuals that are on a sheet. Visual placement is determined by
    /// the layout of the sheet.
    visuals: ?[]const Visual = null,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .custom_action_defaults = "CustomActionDefaults",
        .description = "Description",
        .filter_controls = "FilterControls",
        .images = "Images",
        .layouts = "Layouts",
        .name = "Name",
        .parameter_controls = "ParameterControls",
        .sheet_control_layouts = "SheetControlLayouts",
        .sheet_id = "SheetId",
        .text_boxes = "TextBoxes",
        .title = "Title",
        .visuals = "Visuals",
    };
};
