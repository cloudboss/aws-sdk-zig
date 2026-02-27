/// An object that specifies a relationship with another component type.
pub const Relationship = struct {
    /// The type of the relationship.
    relationship_type: ?[]const u8,

    /// The ID of the target component type associated with this relationship.
    target_component_type_id: ?[]const u8,

    pub const json_field_names = .{
        .relationship_type = "relationshipType",
        .target_component_type_id = "targetComponentTypeId",
    };
};
