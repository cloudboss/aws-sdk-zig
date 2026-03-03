/// Contains an asset model hierarchy used in asset model creation. An asset
/// model hierarchy
/// determines the kind (or type) of asset that can belong to a hierarchy.
pub const AssetModelHierarchyDefinition = struct {
    /// The ID of an asset model for this hierarchy. This can be either the actual
    /// ID in UUID format, or else `externalId:` followed by the external ID, if it
    /// has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    child_asset_model_id: []const u8,

    /// An external ID to assign to the asset model hierarchy. The external ID must
    /// be unique
    /// among asset model hierarchies within this asset model. For more information,
    /// see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID to assign to the asset model hierarchy, if desired. IoT SiteWise
    /// automatically generates a unique ID for you, so this parameter is never
    /// required.
    /// However, if you prefer to supply your own ID instead, you can specify it
    /// here in UUID format.
    /// If you specify your own ID, it must be globally unique.
    id: ?[]const u8 = null,

    /// The name of the asset model hierarchy definition (as specified in the
    /// [CreateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModel.html) or
    /// [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html) API operation).
    name: []const u8,

    pub const json_field_names = .{
        .child_asset_model_id = "childAssetModelId",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
    };
};
