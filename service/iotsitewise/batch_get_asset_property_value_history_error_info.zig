const BatchGetAssetPropertyValueHistoryErrorCode = @import("batch_get_asset_property_value_history_error_code.zig").BatchGetAssetPropertyValueHistoryErrorCode;

/// The error information, such as the error code and the timestamp.
pub const BatchGetAssetPropertyValueHistoryErrorInfo = struct {
    /// The error code.
    error_code: BatchGetAssetPropertyValueHistoryErrorCode,

    /// The date the error occurred, in Unix epoch time.
    error_timestamp: i64,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_timestamp = "errorTimestamp",
    };
};
