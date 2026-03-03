const aws = @import("aws");

const AutoBranchCreationConfig = @import("auto_branch_creation_config.zig").AutoBranchCreationConfig;
const CacheConfig = @import("cache_config.zig").CacheConfig;
const CustomRule = @import("custom_rule.zig").CustomRule;
const JobConfig = @import("job_config.zig").JobConfig;
const Platform = @import("platform.zig").Platform;
const ProductionBranch = @import("production_branch.zig").ProductionBranch;
const RepositoryCloneMethod = @import("repository_clone_method.zig").RepositoryCloneMethod;
const WafConfiguration = @import("waf_configuration.zig").WafConfiguration;

/// Represents the different branches of a repository for building, deploying,
/// and hosting
/// an Amplify app.
pub const App = struct {
    /// The Amazon Resource Name (ARN) of the Amplify app.
    app_arn: []const u8,

    /// The unique ID of the Amplify app.
    app_id: []const u8,

    /// Describes the automated branch creation configuration for the Amplify app.
    auto_branch_creation_config: ?AutoBranchCreationConfig = null,

    /// Describes the automated branch creation glob patterns for the Amplify app.
    auto_branch_creation_patterns: ?[]const []const u8 = null,

    /// The basic authorization credentials for branches for the Amplify app. You
    /// must
    /// base64-encode the authorization credentials and provide them in the format
    /// `user:password`.
    basic_auth_credentials: ?[]const u8 = null,

    /// Describes the content of the build specification (build spec) for the
    /// Amplify app.
    build_spec: ?[]const u8 = null,

    /// The cache configuration for the Amplify app. If you don't specify the
    /// cache configuration `type`, Amplify uses the default
    /// `AMPLIFY_MANAGED` setting.
    cache_config: ?CacheConfig = null,

    /// The Amazon Resource Name (ARN) of the IAM role for an SSR app. The
    /// Compute role allows the Amplify Hosting compute service to securely
    /// access specific Amazon Web Services resources based on the role's
    /// permissions. For more
    /// information about the SSR Compute role, see [Adding an SSR Compute
    /// role](https://docs.aws.amazon.com/amplify/latest/userguide/amplify-SSR-compute-role.html) in the *Amplify User Guide*.
    compute_role_arn: ?[]const u8 = null,

    /// A timestamp of when Amplify created the application.
    create_time: i64,

    /// Describes the custom HTTP headers for the Amplify app.
    custom_headers: ?[]const u8 = null,

    /// Describes the custom redirect and rewrite rules for the Amplify app.
    custom_rules: ?[]const CustomRule = null,

    /// The default domain for the Amplify app.
    default_domain: []const u8,

    /// The description for the Amplify app.
    description: []const u8,

    /// Enables automated branch creation for the Amplify app.
    enable_auto_branch_creation: ?bool = null,

    /// Enables basic authorization for the Amplify app's branches.
    enable_basic_auth: bool,

    /// Enables the auto-building of branches for the Amplify app.
    enable_branch_auto_build: bool,

    /// Automatically disconnect a branch in the Amplify console when you delete a
    /// branch from
    /// your Git repository.
    enable_branch_auto_deletion: ?bool = null,

    /// The environment variables for the Amplify app.
    ///
    /// For a list of the environment variables that are accessible to Amplify by
    /// default, see
    /// [Amplify
    /// Environment
    /// variables](https://docs.aws.amazon.com/amplify/latest/userguide/amplify-console-environment-variables.html) in the *Amplify Hosting User
    /// Guide*.
    environment_variables: []const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the IAM service role for the Amplify app.
    iam_service_role_arn: ?[]const u8 = null,

    /// The configuration details that apply to the jobs for an Amplify app.
    job_config: ?JobConfig = null,

    /// The name for the Amplify app.
    name: []const u8,

    /// The platform for the Amplify app. For a static app, set the platform type to
    /// `WEB`. For a dynamic server-side rendered (SSR) app, set the platform
    /// type to `WEB_COMPUTE`. For an app requiring Amplify Hosting's original SSR
    /// support only, set the platform type to `WEB_DYNAMIC`.
    ///
    /// If you are deploying an SSG only app with Next.js 14 or later, you must use
    /// the
    /// platform type `WEB_COMPUTE`.
    platform: Platform,

    /// Describes the information about a production branch of the Amplify app.
    production_branch: ?ProductionBranch = null,

    /// The Git repository for the Amplify app.
    repository: []const u8,

    /// This is for internal use.
    ///
    /// The Amplify service uses this parameter to specify the authentication
    /// protocol to use
    /// to access the Git repository for an Amplify app. Amplify specifies `TOKEN`
    /// for a GitHub repository, `SIGV4` for an Amazon Web Services CodeCommit
    /// repository, and `SSH` for GitLab and Bitbucket repositories.
    repository_clone_method: ?RepositoryCloneMethod = null,

    /// The tag for the Amplify app.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A timestamp of when Amplify updated the application.
    update_time: i64,

    /// Describes the Firewall configuration for the Amplify app. Firewall
    /// support enables you to protect your hosted applications with a direct
    /// integration with
    /// WAF.
    waf_configuration: ?WafConfiguration = null,

    /// A timestamp of when Amplify created the webhook in your Git
    /// repository.
    webhook_create_time: ?i64 = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_id = "appId",
        .auto_branch_creation_config = "autoBranchCreationConfig",
        .auto_branch_creation_patterns = "autoBranchCreationPatterns",
        .basic_auth_credentials = "basicAuthCredentials",
        .build_spec = "buildSpec",
        .cache_config = "cacheConfig",
        .compute_role_arn = "computeRoleArn",
        .create_time = "createTime",
        .custom_headers = "customHeaders",
        .custom_rules = "customRules",
        .default_domain = "defaultDomain",
        .description = "description",
        .enable_auto_branch_creation = "enableAutoBranchCreation",
        .enable_basic_auth = "enableBasicAuth",
        .enable_branch_auto_build = "enableBranchAutoBuild",
        .enable_branch_auto_deletion = "enableBranchAutoDeletion",
        .environment_variables = "environmentVariables",
        .iam_service_role_arn = "iamServiceRoleArn",
        .job_config = "jobConfig",
        .name = "name",
        .platform = "platform",
        .production_branch = "productionBranch",
        .repository = "repository",
        .repository_clone_method = "repositoryCloneMethod",
        .tags = "tags",
        .update_time = "updateTime",
        .waf_configuration = "wafConfiguration",
        .webhook_create_time = "webhookCreateTime",
    };
};
