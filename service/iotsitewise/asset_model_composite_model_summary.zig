const AssetModelCompositeModelPathSegment = @import("asset_model_composite_model_path_segment.zig").AssetModelCompositeModelPathSegment;

/// Contains a summary of the composite model.
pub const AssetModelCompositeModelSummary = struct {
    /// The description of the composite model that this summary describes..
    description: ?[]const u8,

    /// The external ID of a composite model on this asset model. For more
    /// information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// The ID of the composite model that this summary describes..
    id: []const u8,

    /// The name of the composite model that this summary describes..
    name: []const u8,

    /// The path that includes all the pieces that make up the composite model.
    path: ?[]const AssetModelCompositeModelPathSegment,

    /// The composite model type. Valid values are `AWS/ALARM`, `CUSTOM`, or `
    /// AWS/L4E_ANOMALY`.
    type: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .path = "path",
        .type = "type",
    };
};
