/// Information about a line item asset.
pub const LineItemAssetInformation = struct {
    /// The ID of the asset. An Outpost asset can be a single server within an
    /// Outposts rack or
    /// an Outposts server configuration.
    asset_id: ?[]const u8,

    /// The MAC addresses of the asset.
    mac_address_list: ?[]const []const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .mac_address_list = "MacAddressList",
    };
};
