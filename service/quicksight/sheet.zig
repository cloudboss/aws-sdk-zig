const SheetImage = @import("sheet_image.zig").SheetImage;

/// A *sheet*, which is an object that contains a set of visuals that
/// are viewed together on one page in Quick Sight. Every analysis and dashboard
/// contains at least one sheet. Each sheet contains at least one visualization
/// widget, for
/// example a chart, pivot table, or narrative insight. Sheets can be associated
/// with other
/// components, such as controls, filters, and so on.
pub const Sheet = struct {
    /// A list of images on a sheet.
    images: ?[]const SheetImage = null,

    /// The name of a sheet. This name is displayed on the sheet's tab in the Quick
    /// Sight
    /// console.
    name: ?[]const u8 = null,

    /// The unique identifier associated with a sheet.
    sheet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .images = "Images",
        .name = "Name",
        .sheet_id = "SheetId",
    };
};
