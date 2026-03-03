const AssetModelType = @import("asset_model_type.zig").AssetModelType;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

/// Contains a summary of an asset model.
pub const AssetModelSummary = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the asset model, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:asset-model/${AssetModelId}`
    arn: []const u8,

    /// The type of asset model.
    ///
    /// * **ASSET_MODEL** – (default) An asset model that you can use to create
    ///   assets.
    /// Can't be included as a component in another asset model.
    ///
    /// * **COMPONENT_MODEL** – A reusable component that you can include in the
    ///   composite
    /// models of other asset models. You can't create assets directly from this
    /// type of asset model.
    asset_model_type: ?AssetModelType = null,

    /// The date the asset model was created, in Unix epoch time.
    creation_date: i64,

    /// The asset model description.
    description: []const u8,

    /// The external ID of the asset model. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID of the asset model (used with IoT SiteWise API operations).
    id: []const u8,

    /// The date the asset model was last updated, in Unix epoch time.
    last_update_date: i64,

    /// The name of the asset model.
    name: []const u8,

    /// The current status of the asset model.
    status: AssetModelStatus,

    /// The version number of the asset model.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .asset_model_type = "assetModelType",
        .creation_date = "creationDate",
        .description = "description",
        .external_id = "externalId",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
        .status = "status",
        .version = "version",
    };
};
