const SheetImage = @import("sheet_image.zig").SheetImage;
const Layout = @import("layout.zig").Layout;
const SheetTextBox = @import("sheet_text_box.zig").SheetTextBox;
const Visual = @import("visual.zig").Visual;

/// A tooltip sheet is an object that contains a set of visuals that
/// are used as a tooltip. Every analysis and dashboard must contain at least
/// one non-tooltip sheet.
pub const TooltipSheetDefinition = struct {
    /// A list of images on a tooltip sheet.
    images: ?[]const SheetImage = null,

    /// Layouts define how the components of a tooltip sheet are arranged.
    ///
    /// For more information, see [Types of
    /// layout](https://docs.aws.amazon.com/quicksight/latest/user/types-of-layout.html) in the *Amazon Quick Suite User Guide*.
    layouts: ?[]const Layout = null,

    /// The name of the tooltip sheet. This name is displayed on the sheet's tab in
    /// the Quick
    /// console.
    name: ?[]const u8 = null,

    /// The unique identifier of a tooltip sheet.
    sheet_id: []const u8,

    /// The text boxes that are on a tooltip sheet.
    text_boxes: ?[]const SheetTextBox = null,

    /// A list of the visuals that are on a tooltip sheet.
    visuals: ?[]const Visual = null,

    pub const json_field_names = .{
        .images = "Images",
        .layouts = "Layouts",
        .name = "Name",
        .sheet_id = "SheetId",
        .text_boxes = "TextBoxes",
        .visuals = "Visuals",
    };
};
