/// The platform configuration for jobs that are running on Fargate resources.
/// Jobs that run
/// on Amazon EC2 resources must not specify this parameter.
pub const FargatePlatformConfiguration = struct {
    /// The Fargate platform version where the jobs are running. A platform version
    /// is
    /// specified only for jobs that are running on Fargate resources. If one isn't
    /// specified, the
    /// `LATEST` platform version is used by default. This uses a recent, approved
    /// version of
    /// the Fargate platform for compute resources. For more information, see
    /// [Fargate
    /// platform
    /// versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service Developer Guide*.
    platform_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .platform_version = "platformVersion",
    };
};
