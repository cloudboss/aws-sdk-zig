const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

/// Contains success information for an entry that is associated with the
/// [BatchGetAssetPropertyValueHistory](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValue.html) API.
pub const BatchGetAssetPropertyValueHistorySuccessEntry = struct {
    /// The requested historical values for the specified asset property.
    asset_property_value_history: []const AssetPropertyValue,

    /// The ID of the entry.
    entry_id: []const u8,

    pub const json_field_names = .{
        .asset_property_value_history = "assetPropertyValueHistory",
        .entry_id = "entryId",
    };
};
