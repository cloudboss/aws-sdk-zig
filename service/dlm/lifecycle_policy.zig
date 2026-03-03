const aws = @import("aws");

const PolicyDetails = @import("policy_details.zig").PolicyDetails;
const GettablePolicyStateValues = @import("gettable_policy_state_values.zig").GettablePolicyStateValues;

/// Information about a lifecycle policy.
pub const LifecyclePolicy = struct {
    /// The local date and time when the lifecycle policy was created.
    date_created: ?i64 = null,

    /// The local date and time when the lifecycle policy was last modified.
    date_modified: ?i64 = null,

    /// Indicates whether the policy is a default lifecycle policy or a custom
    /// lifecycle policy.
    ///
    /// * `true` - the policy is a default policy.
    ///
    /// * `false` - the policy is a custom policy.
    default_policy: ?bool = null,

    /// The description of the lifecycle policy.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used to run the operations
    /// specified by
    /// the lifecycle policy.
    execution_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: ?[]const u8 = null,

    /// The configuration of the lifecycle policy
    policy_details: ?PolicyDetails = null,

    /// The identifier of the lifecycle policy.
    policy_id: ?[]const u8 = null,

    /// The activation state of the lifecycle policy.
    state: ?GettablePolicyStateValues = null,

    /// The description of the status.
    status_message: ?[]const u8 = null,

    /// The tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .default_policy = "DefaultPolicy",
        .description = "Description",
        .execution_role_arn = "ExecutionRoleArn",
        .policy_arn = "PolicyArn",
        .policy_details = "PolicyDetails",
        .policy_id = "PolicyId",
        .state = "State",
        .status_message = "StatusMessage",
        .tags = "Tags",
    };
};
