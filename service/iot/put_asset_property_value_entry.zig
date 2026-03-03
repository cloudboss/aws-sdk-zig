const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

/// An asset property value entry containing the following information.
pub const PutAssetPropertyValueEntry = struct {
    /// The ID of the IoT SiteWise asset. You must specify either a `propertyAlias`
    /// or both an `aliasId` and a `propertyId`. Accepts substitution
    /// templates.
    asset_id: ?[]const u8 = null,

    /// Optional. A unique identifier for this entry that you can define to better
    /// track which
    /// message caused an error in case of failure. Accepts substitution templates.
    /// Defaults to a new
    /// UUID.
    entry_id: ?[]const u8 = null,

    /// The name of the property alias associated with your asset property. You must
    /// specify
    /// either a `propertyAlias` or both an `aliasId` and a
    /// `propertyId`. Accepts substitution templates.
    property_alias: ?[]const u8 = null,

    /// The ID of the asset's property. You must specify either a `propertyAlias` or
    /// both an `aliasId` and a `propertyId`. Accepts substitution
    /// templates.
    property_id: ?[]const u8 = null,

    /// A list of property values to insert that each contain timestamp, quality,
    /// and value (TQV)
    /// information.
    property_values: []const AssetPropertyValue,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .entry_id = "entryId",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .property_values = "propertyValues",
    };
};
