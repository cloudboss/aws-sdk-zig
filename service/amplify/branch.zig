const aws = @import("aws");

const Backend = @import("backend.zig").Backend;
const Stage = @import("stage.zig").Stage;

/// The branch for an Amplify app, which maps to a third-party repository
/// branch.
pub const Branch = struct {
    /// The ID of the active job for a branch of an Amplify app.
    active_job_id: []const u8,

    /// A list of custom resources that are linked to this branch.
    associated_resources: ?[]const []const u8,

    backend: ?Backend,

    /// The Amazon Resource Name (ARN) for a backend environment that is part of an
    /// Amplify app.
    ///
    /// This property is available to Amplify Gen 1 apps only. When you deploy
    /// an application with Amplify Gen 2, you provision the app's backend
    /// infrastructure using
    /// Typescript code.
    backend_environment_arn: ?[]const u8,

    /// The basic authorization credentials for a branch of an Amplify app. You must
    /// base64-encode the authorization credentials and provide them in the format
    /// `user:password`.
    basic_auth_credentials: ?[]const u8,

    /// The Amazon Resource Name (ARN) for a branch that is part of an Amplify app.
    branch_arn: []const u8,

    /// The name for the branch that is part of an Amplify app.
    branch_name: []const u8,

    /// The build specification (build spec) content for the branch of an Amplify
    /// app.
    build_spec: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role for a branch of an SSR
    /// app. The Compute role allows the Amplify Hosting compute service to
    /// securely access specific Amazon Web Services resources based on the role's
    /// permissions.
    /// For more information about the SSR Compute role, see [Adding an SSR Compute
    /// role](https://docs.aws.amazon.com/amplify/latest/userguide/amplify-SSR-compute-role.html) in the *Amplify User Guide*.
    compute_role_arn: ?[]const u8,

    /// A timestamp of when Amplify created the branch.
    create_time: i64,

    /// The custom domains for a branch of an Amplify app.
    custom_domains: []const []const u8,

    /// The description for the branch that is part of an Amplify app.
    description: []const u8,

    /// The destination branch if the branch is a pull request branch.
    destination_branch: ?[]const u8,

    /// The display name for the branch. This is used as the default domain prefix.
    display_name: []const u8,

    /// Enables auto-building on push for a branch of an Amplify app.
    enable_auto_build: bool,

    /// Enables basic authorization for a branch of an Amplify app.
    enable_basic_auth: bool,

    /// Enables notifications for a branch that is part of an Amplify app.
    enable_notification: bool,

    /// Enables performance mode for the branch.
    ///
    /// Performance mode optimizes for faster hosting performance by keeping content
    /// cached at
    /// the edge for a longer interval. When performance mode is enabled, hosting
    /// configuration
    /// or code changes can take up to 10 minutes to roll out.
    enable_performance_mode: ?bool,

    /// Enables pull request previews for the branch.
    enable_pull_request_preview: bool,

    /// Specifies whether the skew protection feature is enabled for the branch.
    ///
    /// Deployment skew protection is available to Amplify applications to
    /// eliminate version skew issues between client and servers in web
    /// applications. When you
    /// apply skew protection to a branch, you can ensure that your clients always
    /// interact with
    /// the correct version of server-side assets, regardless of when a deployment
    /// occurs. For
    /// more information about skew protection, see [Skew protection for Amplify
    /// deployments](https://docs.aws.amazon.com/amplify/latest/userguide/skew-protection.html) in the *Amplify User
    /// Guide*.
    enable_skew_protection: ?bool,

    /// The environment variables specific to a branch of an Amplify app.
    environment_variables: []const aws.map.StringMapEntry,

    /// The framework for a branch of an Amplify app.
    framework: []const u8,

    /// The Amplify environment name for the pull request.
    pull_request_environment_name: ?[]const u8,

    /// The source branch if the branch is a pull request branch.
    source_branch: ?[]const u8,

    /// The current stage for the branch that is part of an Amplify app.
    stage: Stage,

    /// The tag for the branch of an Amplify app.
    tags: ?[]const aws.map.StringMapEntry,

    /// The thumbnail URL for the branch of an Amplify app.
    thumbnail_url: ?[]const u8,

    /// The total number of jobs that are part of an Amplify app.
    total_number_of_jobs: []const u8,

    /// The content Time to Live (TTL) for the website in seconds.
    ttl: []const u8,

    /// A timestamp for the last updated time for a branch.
    update_time: i64,

    pub const json_field_names = .{
        .active_job_id = "activeJobId",
        .associated_resources = "associatedResources",
        .backend = "backend",
        .backend_environment_arn = "backendEnvironmentArn",
        .basic_auth_credentials = "basicAuthCredentials",
        .branch_arn = "branchArn",
        .branch_name = "branchName",
        .build_spec = "buildSpec",
        .compute_role_arn = "computeRoleArn",
        .create_time = "createTime",
        .custom_domains = "customDomains",
        .description = "description",
        .destination_branch = "destinationBranch",
        .display_name = "displayName",
        .enable_auto_build = "enableAutoBuild",
        .enable_basic_auth = "enableBasicAuth",
        .enable_notification = "enableNotification",
        .enable_performance_mode = "enablePerformanceMode",
        .enable_pull_request_preview = "enablePullRequestPreview",
        .enable_skew_protection = "enableSkewProtection",
        .environment_variables = "environmentVariables",
        .framework = "framework",
        .pull_request_environment_name = "pullRequestEnvironmentName",
        .source_branch = "sourceBranch",
        .stage = "stage",
        .tags = "tags",
        .thumbnail_url = "thumbnailUrl",
        .total_number_of_jobs = "totalNumberOfJobs",
        .ttl = "ttl",
        .update_time = "updateTime",
    };
};
