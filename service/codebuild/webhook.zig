const WebhookBuildType = @import("webhook_build_type.zig").WebhookBuildType;
const WebhookFilter = @import("webhook_filter.zig").WebhookFilter;
const PullRequestBuildPolicy = @import("pull_request_build_policy.zig").PullRequestBuildPolicy;
const ScopeConfiguration = @import("scope_configuration.zig").ScopeConfiguration;
const WebhookStatus = @import("webhook_status.zig").WebhookStatus;

/// Information about a webhook that connects repository events to a build
/// project in
/// CodeBuild.
pub const Webhook = struct {
    /// A regular expression used to determine which repository branches are built
    /// when a
    /// webhook is triggered. If the name of a branch matches the regular
    /// expression, then it is
    /// built. If `branchFilter` is empty, then all branches are built.
    ///
    /// It is recommended that you use `filterGroups` instead of
    /// `branchFilter`.
    branch_filter: ?[]const u8 = null,

    /// Specifies the type of build this webhook will trigger.
    ///
    /// `RUNNER_BUILDKITE_BUILD` is only available for `NO_SOURCE` source type
    /// projects
    /// configured for Buildkite runner builds. For more information about
    /// CodeBuild-hosted Buildkite runner builds, see [Tutorial: Configure a
    /// CodeBuild-hosted Buildkite
    /// runner](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-runner-buildkite.html) in the *CodeBuild
    /// user guide*.
    build_type: ?WebhookBuildType = null,

    /// An array of arrays of `WebhookFilter` objects used to determine which
    /// webhooks are triggered. At least one `WebhookFilter` in the array must
    /// specify `EVENT` as its `type`.
    ///
    /// For a build to be triggered, at least one filter group in the
    /// `filterGroups` array must pass. For a filter group to pass, each of its
    /// filters must pass.
    filter_groups: ?[]const []const WebhookFilter = null,

    /// A timestamp that indicates the last time a repository's secret token was
    /// modified.
    last_modified_secret: ?i64 = null,

    /// If manualCreation is true, CodeBuild doesn't create a webhook in GitHub and
    /// instead returns `payloadUrl` and
    /// `secret` values for the webhook. The `payloadUrl` and `secret` values in the
    /// output can
    /// be used to manually create a webhook within GitHub.
    ///
    /// manualCreation is only available for GitHub webhooks.
    manual_creation: ?bool = null,

    /// The CodeBuild endpoint where webhook events are sent.
    payload_url: ?[]const u8 = null,

    pull_request_build_policy: ?PullRequestBuildPolicy = null,

    /// The scope configuration for global or organization webhooks.
    ///
    /// Global or organization webhooks are only available for GitHub and Github
    /// Enterprise webhooks.
    scope_configuration: ?ScopeConfiguration = null,

    /// The secret token of the associated repository.
    ///
    /// A Bitbucket webhook does not support `secret`.
    secret: ?[]const u8 = null,

    /// The status of the webhook. Valid values include:
    ///
    /// * `CREATING`: The webhook is being created.
    ///
    /// * `CREATE_FAILED`: The webhook has failed to create.
    ///
    /// * `ACTIVE`: The webhook has succeeded and is active.
    ///
    /// * `DELETING`: The webhook is being deleted.
    status: ?WebhookStatus = null,

    /// A message associated with the status of a webhook.
    status_message: ?[]const u8 = null,

    /// The URL to the webhook.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch_filter = "branchFilter",
        .build_type = "buildType",
        .filter_groups = "filterGroups",
        .last_modified_secret = "lastModifiedSecret",
        .manual_creation = "manualCreation",
        .payload_url = "payloadUrl",
        .pull_request_build_policy = "pullRequestBuildPolicy",
        .scope_configuration = "scopeConfiguration",
        .secret = "secret",
        .status = "status",
        .status_message = "statusMessage",
        .url = "url",
    };
};
