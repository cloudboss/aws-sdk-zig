const SheetImageStaticFileSource = @import("sheet_image_static_file_source.zig").SheetImageStaticFileSource;

/// The source of the image.
pub const SheetImageSource = struct {
    /// The source of the static file that contains the image.
    sheet_image_static_file_source: ?SheetImageStaticFileSource = null,

    pub const json_field_names = .{
        .sheet_image_static_file_source = "SheetImageStaticFileSource",
    };
};
