/// Asset.
pub const Asset = struct {
    /// Amazon Resource Name (ARN) of the asset.
    asset_arn: ?[]const u8 = null,

    /// Latest asset discovery time.
    latest_asset_discovery_time: ?i64 = null,

    pub const json_field_names = .{
        .asset_arn = "AssetArn",
        .latest_asset_discovery_time = "LatestAssetDiscoveryTime",
    };
};
