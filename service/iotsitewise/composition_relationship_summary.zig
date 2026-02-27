/// Contains a summary of the components of the composite model.
pub const CompositionRelationshipSummary = struct {
    /// The ID of a composite model on this asset model.
    asset_model_composite_model_id: []const u8,

    /// The composite model type. Valid values are `AWS/ALARM`, `CUSTOM`, or
    /// ` AWS/L4E_ANOMALY`.
    asset_model_composite_model_type: []const u8,

    /// The ID of the asset model, in UUID format.
    asset_model_id: []const u8,

    pub const json_field_names = .{
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .asset_model_composite_model_type = "assetModelCompositeModelType",
        .asset_model_id = "assetModelId",
    };
};
