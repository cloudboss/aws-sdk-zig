const ApplicationResourceLifecycleConfig = @import("application_resource_lifecycle_config.zig").ApplicationResourceLifecycleConfig;

/// Describes the properties of an application.
pub const ApplicationDescription = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: ?[]const u8,

    /// The name of the application.
    application_name: ?[]const u8,

    /// The names of the configuration templates associated with this application.
    configuration_templates: ?[]const []const u8,

    /// The date when the application was created.
    date_created: ?i64,

    /// The date when the application was last modified.
    date_updated: ?i64,

    /// User-defined description of the application.
    description: ?[]const u8,

    /// The lifecycle settings for the application.
    resource_lifecycle_config: ?ApplicationResourceLifecycleConfig,

    /// The names of the versions for this application.
    versions: ?[]const []const u8,
};
