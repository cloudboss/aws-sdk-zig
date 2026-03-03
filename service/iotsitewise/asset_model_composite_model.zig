const AssetModelProperty = @import("asset_model_property.zig").AssetModelProperty;

/// Contains information about a composite model in an asset model. This object
/// contains the
/// asset property definitions that you define in the composite model.
pub const AssetModelCompositeModel = struct {
    /// The description of the composite model.
    description: ?[]const u8 = null,

    /// The external ID of the asset model composite model. For more information,
    /// see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID of the asset model composite model.
    id: ?[]const u8 = null,

    /// The name of the composite model.
    name: []const u8,

    /// The asset property definitions for this composite model.
    properties: ?[]const AssetModelProperty = null,

    /// The type of the composite model. For alarm composite models, this type is
    /// `AWS/ALARM`.
    @"type": []const u8,

    pub const json_field_names = .{
        .description = "description",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .properties = "properties",
        .@"type" = "type",
    };
};
