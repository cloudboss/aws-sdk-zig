const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const OptionSpecification = @import("option_specification.zig").OptionSpecification;
const Tag = @import("tag.zig").Tag;
const EnvironmentTier = @import("environment_tier.zig").EnvironmentTier;

pub const CreateEnvironmentMessage = struct {
    /// The name of the application that is associated with this environment.
    application_name: []const u8,

    /// If specified, the environment attempts to use this value as the prefix for
    /// the CNAME in
    /// your Elastic Beanstalk environment URL. If not specified, the CNAME is
    /// generated automatically by
    /// appending a random alphanumeric string to the environment name.
    cname_prefix: ?[]const u8 = null,

    /// Your description for this environment.
    description: ?[]const u8 = null,

    /// A unique name for the environment.
    ///
    /// Constraint: Must be from 4 to 40 characters in length. The name can contain
    /// only
    /// letters, numbers, and hyphens. It can't start or end with a hyphen. This
    /// name must be unique
    /// within a region in your account. If the specified name already exists in the
    /// region, Elastic Beanstalk returns an
    /// `InvalidParameterValue` error.
    ///
    /// If you don't specify the `CNAMEPrefix` parameter, the environment name
    /// becomes part of
    /// the CNAME, and therefore part of the visible URL for your application.
    environment_name: ?[]const u8 = null,

    /// The name of the group to which the target environment belongs. Specify a
    /// group name
    /// only if the environment's name is specified in an environment manifest and
    /// not with the
    /// environment name parameter. See [Environment Manifest
    /// (env.yaml)](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environment-cfg-manifest.html) for details.
    group_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an existing IAM role to be used as the
    /// environment's
    /// operations role. If specified, Elastic Beanstalk uses the operations role
    /// for permissions to downstream
    /// services during this call and during subsequent calls acting on this
    /// environment. To specify
    /// an operations role, you must have the `iam:PassRole` permission for the
    /// role. For
    /// more information, see [Operations
    /// roles](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-operationsrole.html) in the
    /// *AWS Elastic Beanstalk Developer Guide*.
    operations_role: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk sets the specified configuration options
    /// to the
    /// requested value in the configuration set for the new environment. These
    /// override the values
    /// obtained from the solution stack or the configuration template.
    option_settings: ?[]const ConfigurationOptionSetting = null,

    /// A list of custom user-defined configuration options to remove from the
    /// configuration
    /// set for this new environment.
    options_to_remove: ?[]const OptionSpecification = null,

    /// The Amazon Resource Name (ARN) of the custom platform to use with the
    /// environment. For
    /// more information, see [Custom
    /// Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html) in the
    /// *AWS Elastic Beanstalk Developer Guide*.
    ///
    /// If you specify `PlatformArn`, don't specify
    /// `SolutionStackName`.
    platform_arn: ?[]const u8 = null,

    /// The name of an Elastic Beanstalk solution stack (platform version) to use
    /// with the environment. If
    /// specified, Elastic Beanstalk sets the configuration values to the default
    /// values associated with the
    /// specified solution stack. For a list of current solution stacks, see
    /// [Elastic Beanstalk Supported
    /// Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html) in the *AWS Elastic Beanstalk
    /// Platforms* guide.
    ///
    /// If you specify `SolutionStackName`, don't specify `PlatformArn` or
    /// `TemplateName`.
    solution_stack_name: ?[]const u8 = null,

    /// Specifies the tags applied to resources in the environment.
    tags: ?[]const Tag = null,

    /// The name of the Elastic Beanstalk configuration template to use with the
    /// environment.
    ///
    /// If you specify `TemplateName`, then don't specify
    /// `SolutionStackName`.
    template_name: ?[]const u8 = null,

    /// Specifies the tier to use in creating this environment. The environment tier
    /// that you
    /// choose determines whether Elastic Beanstalk provisions resources to support
    /// a web application that handles
    /// HTTP(S) requests or a web application that handles background-processing
    /// tasks.
    tier: ?EnvironmentTier = null,

    /// The name of the application version to deploy.
    ///
    /// Default: If not specified, Elastic Beanstalk attempts to deploy the sample
    /// application.
    version_label: ?[]const u8 = null,
};
