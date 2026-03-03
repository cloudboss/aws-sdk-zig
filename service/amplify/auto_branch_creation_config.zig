const aws = @import("aws");

const Stage = @import("stage.zig").Stage;

/// Describes the automated branch creation configuration.
pub const AutoBranchCreationConfig = struct {
    /// The basic authorization credentials for the autocreated branch. You must
    /// base64-encode
    /// the authorization credentials and provide them in the format
    /// `user:password`.
    basic_auth_credentials: ?[]const u8 = null,

    /// The build specification (build spec) for the autocreated branch.
    build_spec: ?[]const u8 = null,

    /// Enables auto building for the autocreated branch.
    enable_auto_build: ?bool = null,

    /// Enables basic authorization for the autocreated branch.
    enable_basic_auth: ?bool = null,

    /// Enables performance mode for the branch.
    ///
    /// Performance mode optimizes for faster hosting performance by keeping content
    /// cached at
    /// the edge for a longer interval. When performance mode is enabled, hosting
    /// configuration
    /// or code changes can take up to 10 minutes to roll out.
    enable_performance_mode: ?bool = null,

    /// Enables pull request previews for the autocreated branch.
    enable_pull_request_preview: ?bool = null,

    /// The environment variables for the autocreated branch.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The framework for the autocreated branch.
    framework: ?[]const u8 = null,

    /// The Amplify environment name for the pull request.
    pull_request_environment_name: ?[]const u8 = null,

    /// Describes the current stage for the autocreated branch.
    stage: ?Stage = null,

    pub const json_field_names = .{
        .basic_auth_credentials = "basicAuthCredentials",
        .build_spec = "buildSpec",
        .enable_auto_build = "enableAutoBuild",
        .enable_basic_auth = "enableBasicAuth",
        .enable_performance_mode = "enablePerformanceMode",
        .enable_pull_request_preview = "enablePullRequestPreview",
        .environment_variables = "environmentVariables",
        .framework = "framework",
        .pull_request_environment_name = "pullRequestEnvironmentName",
        .stage = "stage",
    };
};
