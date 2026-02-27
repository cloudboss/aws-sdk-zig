const ComponentProperty = @import("component_property.zig").ComponentProperty;

/// Represents the state configuration when an action modifies a property of
/// another element
/// within the same component.
pub const MutationActionSetStateParameter = struct {
    /// The name of the component that is being modified.
    component_name: []const u8,

    /// The name of the component property to apply the state configuration to.
    property: []const u8,

    /// The state configuration to assign to the property.
    set: ComponentProperty,

    pub const json_field_names = .{
        .component_name = "componentName",
        .property = "property",
        .set = "set",
    };
};
