/// Input settings for MultiView Settings. You can include exactly one input as
/// enhancement layer.
pub const MultiViewInput = struct {
    /// Specify the input file S3, HTTP, or HTTPS URL for your right eye view video.
    file_input: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_input = "FileInput",
    };
};
