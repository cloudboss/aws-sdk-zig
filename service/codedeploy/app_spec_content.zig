/// A revision for an Lambda or Amazon ECS deployment that is a
/// YAML-formatted or JSON-formatted string. For Lambda and Amazon ECS
/// deployments, the revision is the same as the AppSpec file. This method
/// replaces the
/// deprecated `RawString` data type.
pub const AppSpecContent = struct {
    /// The YAML-formatted or JSON-formatted revision string.
    ///
    /// For an Lambda deployment, the content includes a Lambda
    /// function name, the alias for its original version, and the alias for its
    /// replacement
    /// version. The deployment shifts traffic from the original version of the
    /// Lambda function to the replacement version.
    ///
    /// For an Amazon ECS deployment, the content includes the task name,
    /// information
    /// about the load balancer that serves traffic to the container, and more.
    ///
    /// For both types of deployments, the content can specify Lambda functions
    /// that run at specified hooks, such as `BeforeInstall`, during a deployment.
    content: ?[]const u8,

    /// The SHA256 hash value of the revision content.
    sha_256: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .sha_256 = "sha256",
    };
};
