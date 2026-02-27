const BatchEntryCompletionStatus = @import("batch_entry_completion_status.zig").BatchEntryCompletionStatus;
const BatchGetAssetPropertyValueHistoryErrorInfo = @import("batch_get_asset_property_value_history_error_info.zig").BatchGetAssetPropertyValueHistoryErrorInfo;

/// Contains information for an entry that has been processed by the previous
/// [BatchGetAssetPropertyValueHistory](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValue.html) request.
pub const BatchGetAssetPropertyValueHistorySkippedEntry = struct {
    /// The completion status of each entry that is associated with the
    /// [BatchGetAssetPropertyValueHistory](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValueHistory.html) API.
    completion_status: BatchEntryCompletionStatus,

    /// The ID of the entry.
    entry_id: []const u8,

    /// The error information, such as the error code and the timestamp.
    error_info: ?BatchGetAssetPropertyValueHistoryErrorInfo,

    pub const json_field_names = .{
        .completion_status = "completionStatus",
        .entry_id = "entryId",
        .error_info = "errorInfo",
    };
};
