/// Windows-specific configuration settings for an ISO import, including
/// the edition to install from a multi-edition Windows ISO file.
pub const WindowsConfiguration = struct {
    /// The 1-based index that specifies which Windows edition to install
    /// from a multi-edition Windows ISO file. A Windows ISO can contain a
    /// `.wim` file with multiple image indexes, each representing
    /// a different edition.
    image_index: i64,

    pub const json_field_names = .{
        .image_index = "imageIndex",
    };
};
