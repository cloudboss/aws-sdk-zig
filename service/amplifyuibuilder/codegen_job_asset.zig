/// Describes an asset for a code generation job.
pub const CodegenJobAsset = struct {
    /// The URL to use to access the asset.
    download_url: ?[]const u8,

    pub const json_field_names = .{
        .download_url = "downloadUrl",
    };
};
