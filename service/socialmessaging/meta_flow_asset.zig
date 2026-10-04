/// Represents a single asset file associated with a WhatsApp Flow, including a
/// presigned download URL.
pub const MetaFlowAsset = struct {
    /// The type of asset. Currently the only supported value is FLOW_JSON.
    asset_type: []const u8,

    /// A presigned URL from Meta for downloading the asset. The URL expires after a
    /// short period.
    download_url: []const u8,

    /// The filename of the asset (for example, flow.json).
    name: []const u8,

    pub const json_field_names = .{
        .asset_type = "assetType",
        .download_url = "downloadUrl",
        .name = "name",
    };
};
