const CompositionRelationshipItem = @import("composition_relationship_item.zig").CompositionRelationshipItem;

/// Metadata for the composition relationship established by using
/// `composedAssetModelId` in [
/// `CreateAssetModelCompositeModel`
/// ](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModelCompositeModel.html).
pub const CompositionDetails = struct {
    /// An array detailing the composition relationship for this composite model.
    composition_relationship: ?[]const CompositionRelationshipItem = null,

    pub const json_field_names = .{
        .composition_relationship = "compositionRelationship",
    };
};
