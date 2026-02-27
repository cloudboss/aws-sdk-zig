const BillScenarioCommitmentModificationAction = @import("bill_scenario_commitment_modification_action.zig").BillScenarioCommitmentModificationAction;

/// Represents a successfully created item in a batch operation for bill
/// scenario commitment modifications.
pub const BatchCreateBillScenarioCommitmentModificationItem = struct {
    /// The specific commitment action that was taken.
    commitment_action: ?BillScenarioCommitmentModificationAction,

    /// The group identifier for the created commitment modification.
    group: ?[]const u8,

    /// The unique identifier assigned to the created commitment modification.
    id: ?[]const u8,

    /// The key of the successfully created entry. This can be any valid string.
    /// This key is useful to identify errors associated with any commitment entry
    /// as any error is returned with this key.
    key: ?[]const u8,

    /// The Amazon Web Services account ID associated with the created commitment
    /// modification.
    usage_account_id: ?[]const u8,

    pub const json_field_names = .{
        .commitment_action = "commitmentAction",
        .group = "group",
        .id = "id",
        .key = "key",
        .usage_account_id = "usageAccountId",
    };
};
