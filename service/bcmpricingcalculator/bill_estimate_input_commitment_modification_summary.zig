const BillScenarioCommitmentModificationAction = @import("bill_scenario_commitment_modification_action.zig").BillScenarioCommitmentModificationAction;

/// Summarizes an input commitment modification for a bill estimate.
pub const BillEstimateInputCommitmentModificationSummary = struct {
    /// The specific commitment action taken in this modification.
    commitment_action: ?BillScenarioCommitmentModificationAction,

    /// The group identifier for the commitment modification.
    group: ?[]const u8,

    /// The unique identifier of the commitment modification.
    id: ?[]const u8,

    /// The Amazon Web Services account ID associated with this commitment
    /// modification.
    usage_account_id: ?[]const u8,

    pub const json_field_names = .{
        .commitment_action = "commitmentAction",
        .group = "group",
        .id = "id",
        .usage_account_id = "usageAccountId",
    };
};
