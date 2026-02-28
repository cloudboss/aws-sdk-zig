const aws = @import("aws");

const ComponentPropertyBindingProperties = @import("component_property_binding_properties.zig").ComponentPropertyBindingProperties;
const FormBindingElement = @import("form_binding_element.zig").FormBindingElement;
const ComponentConditionProperty = @import("component_condition_property.zig").ComponentConditionProperty;

/// Describes the configuration for all of a component's properties. Use
/// `ComponentProperty` to specify the values to render or bind by default.
pub const ComponentProperty = struct {
    /// The information to bind the component property to data at runtime.
    binding_properties: ?ComponentPropertyBindingProperties,

    /// The information to bind the component property to form data.
    bindings: ?[]const aws.map.MapEntry(FormBindingElement),

    /// The information to bind the component property to data at runtime. Use this
    /// for collection
    /// components.
    collection_binding_properties: ?ComponentPropertyBindingProperties,

    /// The name of the component that is affected by an event.
    component_name: ?[]const u8,

    /// A list of component properties to concatenate to create the value to assign
    /// to this
    /// component property.
    concat: ?[]const ComponentProperty,

    /// The conditional expression to use to assign a value to the component
    /// property.
    condition: ?*ComponentConditionProperty = null,

    /// Specifies whether the user configured the property in Amplify Studio after
    /// importing it.
    configured: ?bool,

    /// The default value to assign to the component property.
    default_value: ?[]const u8,

    /// An event that occurs in your app. Use this for workflow data binding.
    event: ?[]const u8,

    /// The default value assigned to the property when the component is imported
    /// into an
    /// app.
    imported_value: ?[]const u8,

    /// The data model to use to assign a value to the component property.
    model: ?[]const u8,

    /// The name of the component's property that is affected by an event.
    property: ?[]const u8,

    /// The component type.
    type: ?[]const u8,

    /// An authenticated user attribute to use to assign a value to the component
    /// property.
    user_attribute: ?[]const u8,

    /// The value to assign to the component property.
    value: ?[]const u8,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .bindings = "bindings",
        .collection_binding_properties = "collectionBindingProperties",
        .component_name = "componentName",
        .concat = "concat",
        .condition = "condition",
        .configured = "configured",
        .default_value = "defaultValue",
        .event = "event",
        .imported_value = "importedValue",
        .model = "model",
        .property = "property",
        .type = "type",
        .user_attribute = "userAttribute",
        .value = "value",
    };
};
