const aws = @import("aws");

const ComponentEvent = @import("component_event.zig").ComponentEvent;
const ComponentProperty = @import("component_property.zig").ComponentProperty;

/// A nested UI configuration within a parent `Component`.
pub const ComponentChild = struct {
    /// The list of `ComponentChild` instances for this component.
    children: ?[]const ComponentChild,

    /// The type of the child component.
    component_type: []const u8,

    /// Describes the events that can be raised on the child component. Use for the
    /// workflow
    /// feature in Amplify Studio that allows you to bind events and actions to
    /// components.
    events: ?[]const aws.map.MapEntry(ComponentEvent),

    /// The name of the child component.
    name: []const u8,

    /// Describes the properties of the child component. You can't specify `tags` as
    /// a
    /// valid property for `properties`.
    properties: []const aws.map.MapEntry(ComponentProperty),

    /// The unique ID of the child component in its original source system, such as
    /// Figma.
    source_id: ?[]const u8,

    pub const json_field_names = .{
        .children = "children",
        .component_type = "componentType",
        .events = "events",
        .name = "name",
        .properties = "properties",
        .source_id = "sourceId",
    };
};
