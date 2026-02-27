/// Describes whether StackSets automatically deploys to Organizations accounts
/// that are
/// added to a target organization or organizational unit (OU). For more
/// information, see [Enable or
/// disable automatic deployments for StackSets in
/// Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-manage-auto-deployment.html) in the
/// *CloudFormation User Guide*.
pub const AutoDeployment = struct {
    /// A list of StackSet ARNs that this StackSet depends on for auto-deployment
    /// operations.
    /// When auto-deployment is triggered, operations will be sequenced to ensure
    /// all dependencies
    /// complete successfully before this StackSet's operation begins.
    depends_on: ?[]const []const u8,

    /// If set to `true`, StackSets automatically deploys additional stack instances
    /// to
    /// Organizations accounts that are added to a target organization or
    /// organizational unit
    /// (OU) in the specified Regions. If an account is removed from a target
    /// organization or OU,
    /// StackSets deletes stack instances from the account in the specified Regions.
    enabled: ?bool,

    /// If set to `true`, stack resources are retained when an account is removed
    /// from a
    /// target organization or OU. If set to `false`, stack resources are deleted.
    /// Specify
    /// only if `Enabled` is set to `True`.
    retain_stacks_on_account_removal: ?bool,
};
