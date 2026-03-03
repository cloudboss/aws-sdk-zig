const aws = @import("aws");

const ComponentBindingPropertiesValue = @import("component_binding_properties_value.zig").ComponentBindingPropertiesValue;
const ComponentChild = @import("component_child.zig").ComponentChild;
const ComponentDataConfiguration = @import("component_data_configuration.zig").ComponentDataConfiguration;
const ComponentEvent = @import("component_event.zig").ComponentEvent;
const ComponentProperty = @import("component_property.zig").ComponentProperty;
const ComponentVariant = @import("component_variant.zig").ComponentVariant;

/// Contains the configuration settings for a user interface (UI) element for an
/// Amplify app. A component is configured as a primary, stand-alone UI element.
/// Use
/// `ComponentChild` to configure an instance of a `Component`. A
/// `ComponentChild` instance inherits the configuration of the main
/// `Component`.
pub const Component = struct {
    /// The unique ID of the Amplify app associated with the component.
    app_id: []const u8,

    /// The information to connect a component's properties to data at runtime. You
    /// can't specify
    /// `tags` as a valid property for `bindingProperties`.
    binding_properties: []const aws.map.MapEntry(ComponentBindingPropertiesValue),

    /// A list of the component's `ComponentChild` instances.
    children: ?[]const ComponentChild = null,

    /// The data binding configuration for the component's properties. Use this for
    /// a collection
    /// component. You can't specify `tags` as a valid property for
    /// `collectionProperties`.
    collection_properties: ?[]const aws.map.MapEntry(ComponentDataConfiguration) = null,

    /// The type of the component. This can be an Amplify custom UI component or
    /// another custom component.
    component_type: []const u8,

    /// The time that the component was created.
    created_at: i64,

    /// The name of the backend environment that is a part of the Amplify
    /// app.
    environment_name: []const u8,

    /// Describes the events that can be raised on the component. Use for the
    /// workflow feature in
    /// Amplify Studio that allows you to bind events and actions to
    /// components.
    events: ?[]const aws.map.MapEntry(ComponentEvent) = null,

    /// The unique ID of the component.
    id: []const u8,

    /// The time that the component was modified.
    modified_at: ?i64 = null,

    /// The name of the component.
    name: []const u8,

    /// Describes the component's properties that can be overriden in a customized
    /// instance of the
    /// component. You can't specify `tags` as a valid property for
    /// `overrides`.
    overrides: []const aws.map.MapEntry([]const aws.map.StringMapEntry),

    /// Describes the component's properties. You can't specify `tags` as a valid
    /// property for `properties`.
    properties: []const aws.map.MapEntry(ComponentProperty),

    /// The schema version of the component when it was imported.
    schema_version: ?[]const u8 = null,

    /// The unique ID of the component in its original source system, such as Figma.
    source_id: ?[]const u8 = null,

    /// One or more key-value pairs to use when tagging the component.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of the component's variants. A variant is a unique style
    /// configuration of a main
    /// component.
    variants: []const ComponentVariant,

    pub const json_field_names = .{
        .app_id = "appId",
        .binding_properties = "bindingProperties",
        .children = "children",
        .collection_properties = "collectionProperties",
        .component_type = "componentType",
        .created_at = "createdAt",
        .environment_name = "environmentName",
        .events = "events",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .overrides = "overrides",
        .properties = "properties",
        .schema_version = "schemaVersion",
        .source_id = "sourceId",
        .tags = "tags",
        .variants = "variants",
    };
};
