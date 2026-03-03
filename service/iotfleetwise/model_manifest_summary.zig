const ManifestStatus = @import("manifest_status.zig").ManifestStatus;

/// Information about a vehicle model (model manifest). You can use the API
/// operation to return this information about
/// multiple vehicle models.
pub const ModelManifestSummary = struct {
    /// The Amazon Resource Name (ARN) of the vehicle model.
    arn: ?[]const u8 = null,

    /// The time the vehicle model was created, in seconds since epoch (January 1,
    /// 1970 at
    /// midnight UTC time).
    creation_time: i64,

    /// A brief description of the vehicle model.
    description: ?[]const u8 = null,

    /// The time the vehicle model was last updated, in seconds since epoch (January
    /// 1, 1970
    /// at midnight UTC time).
    last_modification_time: i64,

    /// The name of the vehicle model.
    name: ?[]const u8 = null,

    /// The ARN of the signal catalog associated with the vehicle model.
    signal_catalog_arn: ?[]const u8 = null,

    /// The state of the vehicle model. If the status is `ACTIVE`, the vehicle
    /// model can't be edited. If the status is `DRAFT`, you can edit the vehicle
    /// model.
    status: ?ManifestStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .last_modification_time = "lastModificationTime",
        .name = "name",
        .signal_catalog_arn = "signalCatalogArn",
        .status = "status",
    };
};
