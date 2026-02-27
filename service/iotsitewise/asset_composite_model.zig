const AssetProperty = @import("asset_property.zig").AssetProperty;

/// Contains information about a composite model in an asset. This object
/// contains the asset's
/// properties that you define in the composite model.
pub const AssetCompositeModel = struct {
    /// The description of the composite model.
    description: ?[]const u8,

    /// The external ID of the asset composite model. For more information, see
    /// [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// The ID of the asset composite model.
    id: ?[]const u8,

    /// The name of the composite model.
    name: []const u8,

    /// The asset properties that this composite model defines.
    properties: []const AssetProperty,

    /// The type of the composite model. For alarm composite models, this type is
    /// `AWS/ALARM`.
    type: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .properties = "properties",
        .type = "type",
    };
};
