/// Describes an asset hierarchy that contains a hierarchy's name and ID.
pub const AssetHierarchy = struct {
    /// The external ID of the hierarchy, if it has one. When you update an asset
    /// hierarchy, you
    /// may assign an external ID if it doesn't already have one. You can't change
    /// the external ID of
    /// an asset hierarchy that already has one. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID of the hierarchy. This ID is a `hierarchyId`.
    id: ?[]const u8 = null,

    /// The hierarchy name provided in the
    /// [CreateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModel.html) or [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html)
    /// API operation.
    name: []const u8,

    pub const json_field_names = .{
        .external_id = "externalId",
        .id = "id",
        .name = "name",
    };
};
