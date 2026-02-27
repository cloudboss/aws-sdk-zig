const BatchCreateBillScenarioCommitmentModificationErrorCode = @import("batch_create_bill_scenario_commitment_modification_error_code.zig").BatchCreateBillScenarioCommitmentModificationErrorCode;

/// Represents an error that occurred during a batch create operation for bill
/// scenario commitment modifications.
pub const BatchCreateBillScenarioCommitmentModificationError = struct {
    /// The error code associated with the failed operation.
    error_code: ?BatchCreateBillScenarioCommitmentModificationErrorCode,

    /// A descriptive message for the error that occurred.
    error_message: ?[]const u8,

    /// The key of the entry that caused the error.
    key: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .key = "key",
    };
};
