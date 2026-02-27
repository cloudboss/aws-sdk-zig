/// An object that sets information about the composite component types of a
/// component type.
pub const CompositeComponentTypeRequest = struct {
    /// This is the `componentTypeId` that the `compositeComponentType` refers to.
    component_type_id: ?[]const u8,

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
    };
};
