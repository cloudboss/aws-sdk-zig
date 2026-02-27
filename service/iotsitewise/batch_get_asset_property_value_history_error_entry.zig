const BatchGetAssetPropertyValueHistoryErrorCode = @import("batch_get_asset_property_value_history_error_code.zig").BatchGetAssetPropertyValueHistoryErrorCode;

/// A list of the errors (if any) associated with the batch request. Each error
/// entry
/// contains the `entryId` of the entry that failed.
pub const BatchGetAssetPropertyValueHistoryErrorEntry = struct {
    /// The ID of the entry.
    entry_id: []const u8,

    /// The error code.
    error_code: BatchGetAssetPropertyValueHistoryErrorCode,

    /// The associated error message.
    error_message: []const u8,

    pub const json_field_names = .{
        .entry_id = "entryId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
