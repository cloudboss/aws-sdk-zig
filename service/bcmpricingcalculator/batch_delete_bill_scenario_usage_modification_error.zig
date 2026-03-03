const BatchDeleteBillScenarioUsageModificationErrorCode = @import("batch_delete_bill_scenario_usage_modification_error_code.zig").BatchDeleteBillScenarioUsageModificationErrorCode;

/// Represents an error that occurred when deleting usage in a Bill Scenario.
pub const BatchDeleteBillScenarioUsageModificationError = struct {
    /// The code associated with the error.
    error_code: ?BatchDeleteBillScenarioUsageModificationErrorCode = null,

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
