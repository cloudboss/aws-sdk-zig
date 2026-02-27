const AwsElasticBeanstalkEnvironmentEnvironmentLink = @import("aws_elastic_beanstalk_environment_environment_link.zig").AwsElasticBeanstalkEnvironmentEnvironmentLink;
const AwsElasticBeanstalkEnvironmentOptionSetting = @import("aws_elastic_beanstalk_environment_option_setting.zig").AwsElasticBeanstalkEnvironmentOptionSetting;
const AwsElasticBeanstalkEnvironmentTier = @import("aws_elastic_beanstalk_environment_tier.zig").AwsElasticBeanstalkEnvironmentTier;

/// Contains details about an Elastic Beanstalk environment.
pub const AwsElasticBeanstalkEnvironmentDetails = struct {
    /// The name of the application that is associated with the environment.
    application_name: ?[]const u8,

    /// The URL to the CNAME for this environment.
    cname: ?[]const u8,

    /// The creation date for this environment.
    date_created: ?[]const u8,

    /// The date when this environment was last modified.
    date_updated: ?[]const u8,

    /// A description of the environment.
    description: ?[]const u8,

    /// For load-balanced, autoscaling environments, the URL to the load balancer.
    /// For single-instance environments, the IP address of the instance.
    endpoint_url: ?[]const u8,

    /// The ARN of the environment.
    environment_arn: ?[]const u8,

    /// The identifier of the environment.
    environment_id: ?[]const u8,

    /// Links to other environments in the same group.
    environment_links: ?[]const AwsElasticBeanstalkEnvironmentEnvironmentLink,

    /// The name of the environment.
    environment_name: ?[]const u8,

    /// The configuration setting for the environment.
    option_settings: ?[]const AwsElasticBeanstalkEnvironmentOptionSetting,

    /// The ARN of the platform version for the environment.
    platform_arn: ?[]const u8,

    /// The name of the solution stack that is deployed with the environment.
    solution_stack_name: ?[]const u8,

    /// The current operational status of the environment. Valid values are as
    /// follows:
    ///
    /// * `Aborting`
    ///
    /// * `Launching`
    ///
    /// * `LinkingFrom`
    ///
    /// * `LinkingTo`
    ///
    /// * `Ready`
    ///
    /// * `Terminated`
    ///
    /// * `Terminating`
    ///
    /// * `Updating`
    status: ?[]const u8,

    /// The tier of the environment.
    tier: ?AwsElasticBeanstalkEnvironmentTier,

    /// The application version of the environment.
    version_label: ?[]const u8,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .cname = "Cname",
        .date_created = "DateCreated",
        .date_updated = "DateUpdated",
        .description = "Description",
        .endpoint_url = "EndpointUrl",
        .environment_arn = "EnvironmentArn",
        .environment_id = "EnvironmentId",
        .environment_links = "EnvironmentLinks",
        .environment_name = "EnvironmentName",
        .option_settings = "OptionSettings",
        .platform_arn = "PlatformArn",
        .solution_stack_name = "SolutionStackName",
        .status = "Status",
        .tier = "Tier",
        .version_label = "VersionLabel",
    };
};
