const AccountGateResult = @import("account_gate_result.zig").AccountGateResult;
const StackSetOperationResultStatus = @import("stack_set_operation_result_status.zig").StackSetOperationResultStatus;

/// The structure that contains information about a specified operation's
/// results for a given
/// account in a given Region.
pub const StackSetOperationResultSummary = struct {
    /// [Self-managed permissions] The name of the Amazon Web Services account for
    /// this operation result.
    account: ?[]const u8 = null,

    /// The results of the account gate function CloudFormation invokes, if present,
    /// before proceeding
    /// with StackSet operations in an account.
    account_gate_result: ?AccountGateResult = null,

    /// [Service-managed permissions] The organization root ID or organizational
    /// unit (OU) IDs that
    /// you specified for
    /// [DeploymentTargets](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DeploymentTargets.html).
    organizational_unit_id: ?[]const u8 = null,

    /// The name of the Amazon Web Services Region for this operation result.
    region: ?[]const u8 = null,

    /// The result status of the StackSet operation for the given account in the
    /// given
    /// Region.
    ///
    /// * `CANCELLED`: The operation in the specified account and Region has been
    /// canceled. This is either because a user has stopped the StackSet operation,
    /// or because the
    /// failure tolerance of the StackSet operation has been exceeded.
    ///
    /// * `FAILED`: The operation in the specified account and Region failed.
    ///
    /// If the StackSet operation fails in enough accounts within a Region, the
    /// failure tolerance
    /// for the StackSet operation as a whole might be exceeded.
    ///
    /// * `RUNNING`: The operation in the specified account and Region is currently
    ///   in
    /// progress.
    ///
    /// * `PENDING`: The operation in the specified account and Region has yet to
    /// start.
    ///
    /// * `SUCCEEDED`: The operation in the specified account and Region completed
    /// successfully.
    status: ?StackSetOperationResultStatus = null,

    /// The reason for the assigned result status.
    status_reason: ?[]const u8 = null,
};
