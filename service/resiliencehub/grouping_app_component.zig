/// Creates a new recommended Application Component (AppComponent).
pub const GroupingAppComponent = struct {
    /// Indicates the identifier of an AppComponent.
    app_component_id: []const u8,

    /// Indicates the name of an AppComponent.
    app_component_name: []const u8,

    /// Indicates the type of an AppComponent.
    app_component_type: []const u8,

    pub const json_field_names = .{
        .app_component_id = "appComponentId",
        .app_component_name = "appComponentName",
        .app_component_type = "appComponentType",
    };
};
