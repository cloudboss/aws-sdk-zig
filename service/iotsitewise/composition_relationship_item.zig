/// Represents a composite model that composed an asset model of type
/// `COMPONENT_MODEL`.
pub const CompositionRelationshipItem = struct {
    /// The ID of the component.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
    };
};
