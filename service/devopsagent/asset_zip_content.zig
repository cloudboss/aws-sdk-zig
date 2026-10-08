/// A zip file containing asset files
pub const AssetZipContent = struct {
    /// The zip file bytes
    zip_file: []const u8,

    pub const json_field_names = .{
        .zip_file = "zipFile",
    };
};
