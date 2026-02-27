/// Details about the job error.
pub const ImportAssetFromSignedUrlJobErrorDetails = struct {
    /// Details about the job error.
    asset_name: []const u8,

    pub const json_field_names = .{
        .asset_name = "AssetName",
    };
};
