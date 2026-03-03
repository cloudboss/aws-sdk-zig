const BatchUpdateBillScenarioCommitmentModificationErrorCode = @import("batch_update_bill_scenario_commitment_modification_error_code.zig").BatchUpdateBillScenarioCommitmentModificationErrorCode;

/// Represents an error that occurred when updating a commitment in a Bill
/// Scenario.
pub const BatchUpdateBillScenarioCommitmentModificationError = struct {
    /// The code associated with the error.
    error_code: ?BatchUpdateBillScenarioCommitmentModificationErrorCode = null,

    /// The message that describes the error.
    error_message: ?[]const u8 = null,

    /// The ID of the error.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
    };
};
