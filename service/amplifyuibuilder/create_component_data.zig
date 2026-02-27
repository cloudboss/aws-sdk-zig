const aws = @import("aws");

const ComponentBindingPropertiesValue = @import("component_binding_properties_value.zig").ComponentBindingPropertiesValue;
const ComponentChild = @import("component_child.zig").ComponentChild;
const ComponentDataConfiguration = @import("component_data_configuration.zig").ComponentDataConfiguration;
const ComponentEvent = @import("component_event.zig").ComponentEvent;
const ComponentProperty = @import("component_property.zig").ComponentProperty;
const ComponentVariant = @import("component_variant.zig").ComponentVariant;

/// Represents all of the information that is required to create a component.
pub const CreateComponentData = struct {
    /// The data binding information for the component's properties.
    binding_properties: []const aws.map.MapEntry(ComponentBindingPropertiesValue),

    /// A list of child components that are instances of the main component.
    children: ?[]const ComponentChild,

    /// The data binding configuration for customizing a component's properties. Use
    /// this for a
    /// collection component.
    collection_properties: ?[]const aws.map.MapEntry(ComponentDataConfiguration),

    /// The component type. This can be an Amplify custom UI component or another
    /// custom component.
    component_type: []const u8,

    /// The event configuration for the component. Use for the workflow feature in
    /// Amplify Studio that allows you to bind events and actions to components.
    events: ?[]const aws.map.MapEntry(ComponentEvent),

    /// The name of the component
    name: []const u8,

    /// Describes the component properties that can be overriden to customize an
    /// instance of the
    /// component.
    overrides: []const aws.map.MapEntry([]const aws.map.StringMapEntry),

    /// Describes the component's properties.
    properties: []const aws.map.MapEntry(ComponentProperty),

    /// The schema version of the component when it was imported.
    schema_version: ?[]const u8,

    /// The unique ID of the component in its original source system, such as Figma.
    source_id: ?[]const u8,

    /// One or more key-value pairs to use when tagging the component data.
    tags: ?[]const aws.map.StringMapEntry,

    /// A list of the unique variants of this component.
    variants: []const ComponentVariant,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .children = "children",
        .collection_properties = "collectionProperties",
        .component_type = "componentType",
        .events = "events",
        .name = "name",
        .overrides = "overrides",
        .properties = "properties",
        .schema_version = "schemaVersion",
        .source_id = "sourceId",
        .tags = "tags",
        .variants = "variants",
    };
};
