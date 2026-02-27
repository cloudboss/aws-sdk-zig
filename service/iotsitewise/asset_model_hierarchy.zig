/// Describes an asset hierarchy that contains a hierarchy's name, ID, and child
/// asset model
/// ID that specifies the type of asset that can be in this hierarchy.
pub const AssetModelHierarchy = struct {
    /// The ID of the asset model, in UUID format. All assets in this hierarchy must
    /// be instances of the
    /// `childAssetModelId` asset model. IoT SiteWise will always return the actual
    /// asset model ID for this value. However, when you are specifying this value
    /// as part of a call to
    /// [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html), you may provide either the asset model ID or else `externalId:`
    /// followed by the asset model's external ID. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    child_asset_model_id: []const u8,

    /// The external ID (if any) provided in the
    /// [CreateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModel.html) or [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html)
    /// operation. You can assign an external ID by specifying
    /// this value as part of a call to
    /// [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html). However, you can't change the external ID if one is already assigned. For more information, see [Using external IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// The ID of the asset model hierarchy. This ID is a `hierarchyId`.
    ///
    /// * If you are callling
    ///   [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html) to create a
    /// *new* hierarchy: You can specify its ID here, if desired.
    /// IoT SiteWise automatically generates a unique ID for you, so this parameter
    /// is never required.
    /// However, if you prefer to supply your own ID instead, you can specify it
    /// here in UUID format.
    /// If you specify your own ID, it must be globally unique.
    ///
    /// * If you are calling UpdateAssetModel to modify an *existing*
    /// hierarchy: This can be either the actual ID in UUID format, or else
    /// `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    id: ?[]const u8,

    /// The name of the asset model hierarchy that you specify by using the
    /// [CreateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModel.html) or
    /// [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html) API operation.
    name: []const u8,

    pub const json_field_names = .{
        .child_asset_model_id = "childAssetModelId",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
    };
};
