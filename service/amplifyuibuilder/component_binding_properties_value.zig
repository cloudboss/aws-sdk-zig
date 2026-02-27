const ComponentBindingPropertiesValueProperties = @import("component_binding_properties_value_properties.zig").ComponentBindingPropertiesValueProperties;

/// Represents the data binding configuration for a component at runtime. You
/// can use
/// `ComponentBindingPropertiesValue` to add exposed properties to a component
/// to
/// allow different values to be entered when a component is reused in different
/// places in an
/// app.
pub const ComponentBindingPropertiesValue = struct {
    /// Describes the properties to customize with data at runtime.
    binding_properties: ?ComponentBindingPropertiesValueProperties,

    /// The default value of the property.
    default_value: ?[]const u8,

    /// The property type.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .default_value = "defaultValue",
        .@"type" = "type",
    };
};
