/// Vilter by entity.
pub const FilterByEntity = struct {
    /// The entity Id.
    entity_id: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
    };
};
