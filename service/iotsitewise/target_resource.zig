/// The resource the action will be taken on. This can include asset-based
/// resources and
/// computation model resources.
pub const TargetResource = struct {
    /// The ID of the asset, in UUID format.
    asset_id: ?[]const u8 = null,

    /// The ID of the computation model.
    computation_model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .computation_model_id = "computationModelId",
    };
};
