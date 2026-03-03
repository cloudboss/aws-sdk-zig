const aws = @import("aws");

const ComponentProperty = @import("component_property.zig").ComponentProperty;
const MutationActionSetStateParameter = @import("mutation_action_set_state_parameter.zig").MutationActionSetStateParameter;

/// Represents the event action configuration for an element of a `Component` or
/// `ComponentChild`. Use for the workflow feature in Amplify Studio
/// that allows you to bind events and actions to components. `ActionParameters`
/// defines the action that is performed when an event occurs on the component.
pub const ActionParameters = struct {
    /// The HTML anchor link to the location to open. Specify this value for a
    /// navigation
    /// action.
    anchor: ?ComponentProperty = null,

    /// A dictionary of key-value pairs mapping Amplify Studio properties to fields
    /// in a data model. Use when the action performs an operation on an Amplify
    /// DataStore model.
    fields: ?[]const aws.map.MapEntry(ComponentProperty) = null,

    /// Specifies whether the user should be signed out globally. Specify this value
    /// for an auth
    /// sign out action.
    global: ?ComponentProperty = null,

    /// The unique ID of the component that the `ActionParameters` apply to.
    id: ?ComponentProperty = null,

    /// The name of the data model. Use when the action performs an operation on an
    /// Amplify DataStore model.
    model: ?[]const u8 = null,

    /// A key-value pair that specifies the state property name and its initial
    /// value.
    state: ?MutationActionSetStateParameter = null,

    /// The element within the same component to modify when the action occurs.
    target: ?ComponentProperty = null,

    /// The type of navigation action. Valid values are `url` and `anchor`.
    /// This value is required for a navigation action.
    @"type": ?ComponentProperty = null,

    /// The URL to the location to open. Specify this value for a navigation action.
    url: ?ComponentProperty = null,

    pub const json_field_names = .{
        .anchor = "anchor",
        .fields = "fields",
        .global = "global",
        .id = "id",
        .model = "model",
        .state = "state",
        .target = "target",
        .@"type" = "type",
        .url = "url",
    };
};
