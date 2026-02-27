const BatchGetAssetPropertyAggregatesErrorCode = @import("batch_get_asset_property_aggregates_error_code.zig").BatchGetAssetPropertyAggregatesErrorCode;

/// Contains the error code and the timestamp for an asset property aggregate
/// entry that is
/// associated with the
/// [BatchGetAssetPropertyAggregates](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyAggregates.html) API.
pub const BatchGetAssetPropertyAggregatesErrorInfo = struct {
    /// The error code.
    error_code: BatchGetAssetPropertyAggregatesErrorCode,

    /// The date the error occurred, in Unix epoch time.
    error_timestamp: i64,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_timestamp = "errorTimestamp",
    };
};
