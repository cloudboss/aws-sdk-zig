const BatchUpdateBillScenarioUsageModificationErrorCode = @import("batch_update_bill_scenario_usage_modification_error_code.zig").BatchUpdateBillScenarioUsageModificationErrorCode;

/// Represents an error that occurred when updating usage in a Bill Scenario.
pub const BatchUpdateBillScenarioUsageModificationError = struct {
    /// The code associated with the error.
    error_code: ?BatchUpdateBillScenarioUsageModificationErrorCode,

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
