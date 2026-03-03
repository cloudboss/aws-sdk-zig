const AssetModelPropertyDefinition = @import("asset_model_property_definition.zig").AssetModelPropertyDefinition;

/// Contains a composite model definition in an asset model. This composite
/// model definition
/// is applied to all assets created from the asset model.
pub const AssetModelCompositeModelDefinition = struct {
    /// The description of the composite model.
    description: ?[]const u8 = null,

    /// An external ID to assign to the composite model. The external ID must be
    /// unique among
    /// composite models within this asset model. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID to assign to the composite model, if desired. IoT SiteWise
    /// automatically generates a unique ID for you, so this parameter is never
    /// required.
    /// However, if you prefer to supply your own ID instead, you can specify it
    /// here in UUID format.
    /// If you specify your own ID, it must be globally unique.
    id: ?[]const u8 = null,

    /// The name of the composite model.
    name: []const u8,

    /// The asset property definitions for this composite model.
    properties: ?[]const AssetModelPropertyDefinition = null,

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
