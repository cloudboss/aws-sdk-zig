const BatchDeleteBillScenarioCommitmentModificationErrorCode = @import("batch_delete_bill_scenario_commitment_modification_error_code.zig").BatchDeleteBillScenarioCommitmentModificationErrorCode;

/// Represents an error that occurred when deleting a commitment in a Bill
/// Scenario.
pub const BatchDeleteBillScenarioCommitmentModificationError = struct {
    /// The code associated with the error.
    error_code: ?BatchDeleteBillScenarioCommitmentModificationErrorCode,

    /// The message that describes the error.
    error_message: ?[]const u8,

    /// The ID of the error.
    id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
    };
};
