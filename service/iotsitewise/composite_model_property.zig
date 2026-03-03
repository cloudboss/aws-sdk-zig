const Property = @import("property.zig").Property;

/// Contains information about a composite model property on an asset.
pub const CompositeModelProperty = struct {
    asset_property: Property,

    /// The external ID of the composite model that contains the property. For more
    /// information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID of the composite model that contains the property.
    id: ?[]const u8 = null,

    /// The name of the property.
    name: []const u8,

    /// The type of the composite model that defines this property.
    @"type": []const u8,

    pub const json_field_names = .{
        .asset_property = "assetProperty",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .@"type" = "type",
    };
};
