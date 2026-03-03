const aws = @import("aws");

const ComponentBindingPropertiesValue = @import("component_binding_properties_value.zig").ComponentBindingPropertiesValue;
const ComponentChild = @import("component_child.zig").ComponentChild;
const ComponentDataConfiguration = @import("component_data_configuration.zig").ComponentDataConfiguration;
const ComponentEvent = @import("component_event.zig").ComponentEvent;
const ComponentProperty = @import("component_property.zig").ComponentProperty;
const ComponentVariant = @import("component_variant.zig").ComponentVariant;

/// Updates and saves all of the information about a component, based on
/// component ID.
pub const UpdateComponentData = struct {
    /// The data binding information for the component's properties.
    binding_properties: ?[]const aws.map.MapEntry(ComponentBindingPropertiesValue) = null,

    /// The components that are instances of the main component.
    children: ?[]const ComponentChild = null,

    /// The configuration for binding a component's properties to a data model. Use
    /// this for a
    /// collection component.
    collection_properties: ?[]const aws.map.MapEntry(ComponentDataConfiguration) = null,

    /// The type of the component. This can be an Amplify custom UI component or
    /// another custom component.
    component_type: ?[]const u8 = null,

    /// The event configuration for the component. Use for the workflow feature in
    /// Amplify Studio that allows you to bind events and actions to components.
    events: ?[]const aws.map.MapEntry(ComponentEvent) = null,

    /// The unique ID of the component to update.
    id: ?[]const u8 = null,

    /// The name of the component to update.
    name: ?[]const u8 = null,

    /// Describes the properties that can be overriden to customize the component.
    overrides: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// Describes the component's properties.
    properties: ?[]const aws.map.MapEntry(ComponentProperty) = null,

    /// The schema version of the component when it was imported.
    schema_version: ?[]const u8 = null,

    /// The unique ID of the component in its original source system, such as Figma.
    source_id: ?[]const u8 = null,

    /// A list of the unique variants of the main component being updated.
    variants: ?[]const ComponentVariant = null,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .children = "children",
        .collection_properties = "collectionProperties",
        .component_type = "componentType",
        .events = "events",
        .id = "id",
        .name = "name",
        .overrides = "overrides",
        .properties = "properties",
        .schema_version = "schemaVersion",
        .source_id = "sourceId",
        .variants = "variants",
    };
};
