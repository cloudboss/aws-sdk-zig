/// An object that returns information about the composite component types of a
/// component type.
pub const CompositeComponentTypeResponse = struct {
    /// This is the `componentTypeId` that this `compositeComponentType` refers to.
    component_type_id: ?[]const u8 = null,

    /// This boolean indicates whether this `compositeComponentType` is inherited
    /// from its parent.
    is_inherited: ?bool = null,

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
        .is_inherited = "isInherited",
    };
};
