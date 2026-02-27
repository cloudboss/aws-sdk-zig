const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

/// Contains success information for an entry that is associated with the
/// [BatchGetAssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValue.html) API.
pub const BatchGetAssetPropertyValueSuccessEntry = struct {
    asset_property_value: ?AssetPropertyValue,

    /// The ID of the entry.
    entry_id: []const u8,

    pub const json_field_names = .{
        .asset_property_value = "assetPropertyValue",
        .entry_id = "entryId",
    };
};
