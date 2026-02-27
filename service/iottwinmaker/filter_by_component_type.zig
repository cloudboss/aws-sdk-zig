/// Filter by component type.
pub const FilterByComponentType = struct {
    /// The component type Id.
    component_type_id: []const u8,

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
    };
};
