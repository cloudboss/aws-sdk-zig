const BatchCreateBillScenarioUsageModificationErrorCode = @import("batch_create_bill_scenario_usage_modification_error_code.zig").BatchCreateBillScenarioUsageModificationErrorCode;

/// Represents an error that occurred during a batch create operation for bill
/// scenario usage modifications.
pub const BatchCreateBillScenarioUsageModificationError = struct {
    /// The error code associated with the failed operation.
    error_code: ?BatchCreateBillScenarioUsageModificationErrorCode = null,

    /// A descriptive message for the error that occurred.
    error_message: ?[]const u8 = null,

    /// The key of the entry that caused the error.
    key: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .key = "key",
    };
};
