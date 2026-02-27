const aws = @import("aws");

const PolicyTypeValues = @import("policy_type_values.zig").PolicyTypeValues;
const GettablePolicyStateValues = @import("gettable_policy_state_values.zig").GettablePolicyStateValues;

/// Summary information about a lifecycle policy.
pub const LifecyclePolicySummary = struct {
    /// **[Default policies only]** The type of default policy. Values include:
    ///
    /// * `VOLUME` - Default policy for EBS snapshots
    ///
    /// * `INSTANCE` - Default policy for EBS-backed AMIs
    default_policy: ?bool,

    /// The description of the lifecycle policy.
    description: ?[]const u8,

    /// The identifier of the lifecycle policy.
    policy_id: ?[]const u8,

    /// The type of policy. `EBS_SNAPSHOT_MANAGEMENT` indicates that the policy
    /// manages the lifecycle of Amazon EBS snapshots. `IMAGE_MANAGEMENT`
    /// indicates that the policy manages the lifecycle of EBS-backed AMIs.
    /// `EVENT_BASED_POLICY` indicates that the policy automates cross-account
    /// snapshot copies for snapshots that are shared with your account.
    policy_type: ?PolicyTypeValues,

    /// The activation state of the lifecycle policy.
    state: ?GettablePolicyStateValues,

    /// The tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .default_policy = "DefaultPolicy",
        .description = "Description",
        .policy_id = "PolicyId",
        .policy_type = "PolicyType",
        .state = "State",
        .tags = "Tags",
    };
};
