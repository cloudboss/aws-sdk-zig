const CoreNetworkPolicyAlias = @import("core_network_policy_alias.zig").CoreNetworkPolicyAlias;
const ChangeSetState = @import("change_set_state.zig").ChangeSetState;

/// Describes a core network policy version.
pub const CoreNetworkPolicyVersion = struct {
    /// Whether a core network policy is the current policy or the most recently
    /// submitted policy.
    alias: ?CoreNetworkPolicyAlias,

    /// The status of the policy version change set.
    change_set_state: ?ChangeSetState,

    /// The ID of a core network.
    core_network_id: ?[]const u8,

    /// The timestamp when a core network policy version was created.
    created_at: ?i64,

    /// The description of a core network policy version.
    description: ?[]const u8,

    /// The ID of the policy version.
    policy_version_id: ?i32,

    pub const json_field_names = .{
        .alias = "Alias",
        .change_set_state = "ChangeSetState",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .description = "Description",
        .policy_version_id = "PolicyVersionId",
    };
};
