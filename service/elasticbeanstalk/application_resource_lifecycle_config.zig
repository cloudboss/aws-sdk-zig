const ApplicationVersionLifecycleConfig = @import("application_version_lifecycle_config.zig").ApplicationVersionLifecycleConfig;

/// The resource lifecycle configuration for an application. Defines lifecycle
/// settings for
/// resources that belong to the application, and the service role that AWS
/// Elastic Beanstalk assumes
/// in order to apply lifecycle settings. The version lifecycle configuration
/// defines lifecycle
/// settings for application versions.
pub const ApplicationResourceLifecycleConfig = struct {
    /// The ARN of an IAM service role that Elastic Beanstalk has permission to
    /// assume.
    ///
    /// The `ServiceRole` property is required the first time that you provide a
    /// `VersionLifecycleConfig` for the application in one of the supporting calls
    /// (`CreateApplication` or `UpdateApplicationResourceLifecycle`). After
    /// you provide it once, in either one of the calls, Elastic Beanstalk persists
    /// the Service Role with the
    /// application, and you don't need to specify it again in subsequent
    /// `UpdateApplicationResourceLifecycle` calls. You can, however, specify it in
    /// subsequent calls to change the Service Role to another value.
    service_role: ?[]const u8 = null,

    /// Defines lifecycle settings for application versions.
    version_lifecycle_config: ?ApplicationVersionLifecycleConfig = null,
};
