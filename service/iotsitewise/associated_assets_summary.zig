const AssetHierarchy = @import("asset_hierarchy.zig").AssetHierarchy;
const AssetStatus = @import("asset_status.zig").AssetStatus;

/// Contains a summary of an associated asset.
pub const AssociatedAssetsSummary = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the asset, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:asset/${AssetId}`
    arn: []const u8,

    /// The ID of the asset model used to create the asset.
    asset_model_id: []const u8,

    /// The date the asset was created, in Unix epoch time.
    creation_date: i64,

    /// A description for the asset.
    description: ?[]const u8,

    /// The external ID of the asset. For more information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// A list of asset hierarchies that each contain a `hierarchyId`. A hierarchy
    /// specifies allowed parent/child asset relationships.
    hierarchies: []const AssetHierarchy,

    /// The ID of the asset, in UUID format.
    id: []const u8,

    /// The date the asset was last updated, in Unix epoch time.
    last_update_date: i64,

    /// The name of the asset.
    name: []const u8,

    /// The current status of the asset.
    status: AssetStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .asset_model_id = "assetModelId",
        .creation_date = "creationDate",
        .description = "description",
        .external_id = "externalId",
        .hierarchies = "hierarchies",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
        .status = "status",
    };
};
