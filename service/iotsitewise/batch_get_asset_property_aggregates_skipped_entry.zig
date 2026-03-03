const BatchEntryCompletionStatus = @import("batch_entry_completion_status.zig").BatchEntryCompletionStatus;
const BatchGetAssetPropertyAggregatesErrorInfo = @import("batch_get_asset_property_aggregates_error_info.zig").BatchGetAssetPropertyAggregatesErrorInfo;

/// Contains information for an entry that has been processed by the previous
/// [BatchGetAssetPropertyAggregates](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyAggregates.html) request.
pub const BatchGetAssetPropertyAggregatesSkippedEntry = struct {
    /// The completion status of each entry that is associated with the
    /// [BatchGetAssetPropertyAggregates](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyAggregates.html) API.
    completion_status: BatchEntryCompletionStatus,

    /// The ID of the entry.
    entry_id: []const u8,

    /// The error information, such as the error code and the timestamp.
    error_info: ?BatchGetAssetPropertyAggregatesErrorInfo = null,

    pub const json_field_names = .{
        .completion_status = "completionStatus",
        .entry_id = "entryId",
        .error_info = "errorInfo",
    };
};
