/// Contains a summary of a component. This is a read-only data type that is
/// returned by
/// `ListComponents`.
pub const ComponentSummary = struct {
    /// The unique ID of the Amplify app associated with the component.
    app_id: []const u8,

    /// The component type.
    component_type: []const u8,

    /// The name of the backend environment that is a part of the Amplify
    /// app.
    environment_name: []const u8,

    /// The unique ID of the component.
    id: []const u8,

    /// The name of the component.
    name: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .component_type = "componentType",
        .environment_name = "environmentName",
        .id = "id",
        .name = "name",
    };
};
