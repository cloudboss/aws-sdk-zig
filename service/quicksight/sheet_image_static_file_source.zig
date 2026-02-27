/// The source of the static file that contains the image.
pub const SheetImageStaticFileSource = struct {
    /// The ID of the static file that contains the image.
    static_file_id: []const u8,

    pub const json_field_names = .{
        .static_file_id = "StaticFileId",
    };
};
