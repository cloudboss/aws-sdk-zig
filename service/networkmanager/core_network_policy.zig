const CoreNetworkPolicyAlias = @import("core_network_policy_alias.zig").CoreNetworkPolicyAlias;
const ChangeSetState = @import("change_set_state.zig").ChangeSetState;
const CoreNetworkPolicyError = @import("core_network_policy_error.zig").CoreNetworkPolicyError;

/// Describes a core network policy. You can have only one LIVE Core Policy.
pub const CoreNetworkPolicy = struct {
    /// Whether a core network policy is the current LIVE policy or the most
    /// recently submitted policy.
    alias: ?CoreNetworkPolicyAlias = null,

    /// The state of a core network policy.
    change_set_state: ?ChangeSetState = null,

    /// The ID of a core network.
    core_network_id: ?[]const u8 = null,

    /// The timestamp when a core network policy was created.
    created_at: ?i64 = null,

    /// The description of a core network policy.
    description: ?[]const u8 = null,

    /// Describes a core network policy.
    policy_document: ?[]const u8 = null,

    /// Describes any errors in a core network policy.
    policy_errors: ?[]const CoreNetworkPolicyError = null,

    /// The ID of the policy version.
    policy_version_id: ?i32 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .change_set_state = "ChangeSetState",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .description = "Description",
        .policy_document = "PolicyDocument",
        .policy_errors = "PolicyErrors",
        .policy_version_id = "PolicyVersionId",
    };
};
