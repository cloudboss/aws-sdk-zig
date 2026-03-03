const BillScenarioCommitmentModificationAction = @import("bill_scenario_commitment_modification_action.zig").BillScenarioCommitmentModificationAction;

/// Represents an entry object in the batch operation to create bill scenario
/// commitment modifications.
pub const BatchCreateBillScenarioCommitmentModificationEntry = struct {
    /// The specific commitment action to be taken (e.g., adding a Reserved Instance
    /// or Savings Plan).
    commitment_action: BillScenarioCommitmentModificationAction,

    /// An optional group identifier for the commitment modification.
    group: ?[]const u8 = null,

    /// A unique identifier for this entry in the batch operation. This can be any
    /// valid string. This key is useful to identify errors associated with any
    /// commitment entry as any error is returned with this key.
    key: []const u8,

    /// The Amazon Web Services account ID to which this commitment will be applied
    /// to.
    usage_account_id: []const u8,

    pub const json_field_names = .{
        .commitment_action = "commitmentAction",
        .group = "group",
        .key = "key",
        .usage_account_id = "usageAccountId",
    };
};
