const SpaceAppLifecycleManagement = @import("space_app_lifecycle_management.zig").SpaceAppLifecycleManagement;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// The application settings for a Code Editor space.
pub const SpaceCodeEditorAppSettings = struct {
    /// Settings that are used to configure and manage the lifecycle of CodeEditor
    /// applications in a space.
    app_lifecycle_management: ?SpaceAppLifecycleManagement,

    default_resource_spec: ?ResourceSpec,

    pub const json_field_names = .{
        .app_lifecycle_management = "AppLifecycleManagement",
        .default_resource_spec = "DefaultResourceSpec",
    };
};
