const AssetCompositeModelPathSegment = @import("asset_composite_model_path_segment.zig").AssetCompositeModelPathSegment;

/// Contains a summary of the composite model for a specific asset.
pub const AssetCompositeModelSummary = struct {
    /// A description of the composite model that this summary describes.
    description: []const u8,

    /// An external ID to assign to the asset model.
    ///
    /// If the composite model is a derived composite model, or one nested inside a
    /// component
    /// model, you can only set the external ID using
    /// `UpdateAssetModelCompositeModel` and
    /// specifying the derived ID of the model or property from the created model
    /// it's a part
    /// of.
    external_id: ?[]const u8,

    /// The ID of the composite model that this summary describes.
    id: []const u8,

    /// The name of the composite model that this summary describes.
    name: []const u8,

    /// The path that includes all the components of the asset model for the asset.
    path: []const AssetCompositeModelPathSegment,

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
    @"type": []const u8,

    pub const json_field_names = .{
        .description = "description",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .path = "path",
        .@"type" = "type",
    };
};
