const EnvironmentLink = @import("environment_link.zig").EnvironmentLink;
const EnvironmentHealth = @import("environment_health.zig").EnvironmentHealth;
const EnvironmentHealthStatus = @import("environment_health_status.zig").EnvironmentHealthStatus;
const EnvironmentResourcesDescription = @import("environment_resources_description.zig").EnvironmentResourcesDescription;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const EnvironmentTier = @import("environment_tier.zig").EnvironmentTier;

/// Describes the properties of an environment.
pub const EnvironmentDescription = struct {
    /// Indicates if there is an in-progress environment configuration update or
    /// application
    /// version deployment that you can cancel.
    ///
    /// `true:` There is an update in progress.
    ///
    /// `false:` There are no updates currently in progress.
    abortable_operation_in_progress: ?bool = null,

    /// The name of the application associated with this environment.
    application_name: ?[]const u8 = null,

    /// The URL to the CNAME for this environment.
    cname: ?[]const u8 = null,

    /// The creation date for this environment.
    date_created: ?i64 = null,

    /// The last modified date for this environment.
    date_updated: ?i64 = null,

    /// Describes this environment.
    description: ?[]const u8 = null,

    /// For load-balanced, autoscaling environments, the URL to the LoadBalancer.
    /// For
    /// single-instance environments, the IP address of the instance.
    endpoint_url: ?[]const u8 = null,

    /// The environment's Amazon Resource Name (ARN), which can be used in other API
    /// requests that require an ARN.
    environment_arn: ?[]const u8 = null,

    /// The ID of this environment.
    environment_id: ?[]const u8 = null,

    /// A list of links to other environments in the same group.
    environment_links: ?[]const EnvironmentLink = null,

    /// The name of this environment.
    environment_name: ?[]const u8 = null,

    /// Describes the health status of the environment. AWS Elastic Beanstalk
    /// indicates the
    /// failure levels for a running environment:
    ///
    /// * `Red`: Indicates the environment is not responsive. Occurs when three or
    ///   more
    /// consecutive failures occur for an environment.
    ///
    /// * `Yellow`: Indicates that something is wrong. Occurs when two consecutive
    /// failures occur for an environment.
    ///
    /// * `Green`: Indicates the environment is healthy and fully functional.
    ///
    /// * `Grey`: Default health for a new environment. The environment is not fully
    /// launched and health checks have not started or health checks are suspended
    /// during an
    /// `UpdateEnvironment` or `RestartEnvironment` request.
    ///
    /// Default: `Grey`
    health: ?EnvironmentHealth = null,

    /// Returns the health status of the application running in your environment.
    /// For more
    /// information, see [Health Colors and
    /// Statuses](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-status.html).
    health_status: ?EnvironmentHealthStatus = null,

    /// The Amazon Resource Name (ARN) of the environment's operations role. For
    /// more information,
    /// see [Operations
    /// roles](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-operationsrole.html) in the *AWS Elastic Beanstalk Developer Guide*.
    operations_role: ?[]const u8 = null,

    /// The ARN of the platform version.
    platform_arn: ?[]const u8 = null,

    /// The description of the AWS resources used by this environment.
    resources: ?EnvironmentResourcesDescription = null,

    /// The name of the `SolutionStack` deployed with this environment.
    solution_stack_name: ?[]const u8 = null,

    /// The current operational status of the environment:
    ///
    /// * `Launching`: Environment is in the process of initial deployment.
    ///
    /// * `Updating`: Environment is in the process of updating its configuration
    /// settings or application version.
    ///
    /// * `Ready`: Environment is available to have an action performed on it, such
    ///   as
    /// update or terminate.
    ///
    /// * `Terminating`: Environment is in the shut-down process.
    ///
    /// * `Terminated`: Environment is not running.
    status: ?EnvironmentStatus = null,

    /// The name of the configuration template used to originally launch this
    /// environment.
    template_name: ?[]const u8 = null,

    /// Describes the current tier of this environment.
    tier: ?EnvironmentTier = null,

    /// The application version deployed in this environment.
    version_label: ?[]const u8 = null,
};
