const BatchGetAssetPropertyAggregatesErrorCode = @import("batch_get_asset_property_aggregates_error_code.zig").BatchGetAssetPropertyAggregatesErrorCode;

/// Contains error information for an asset property aggregate entry that is
/// associated with
/// the
/// [BatchGetAssetPropertyAggregates](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyAggregates.html) API.
pub const BatchGetAssetPropertyAggregatesErrorEntry = struct {
    /// The ID of the entry.
    entry_id: []const u8,

    /// The error code.
    error_code: BatchGetAssetPropertyAggregatesErrorCode,

    /// The associated error message.
    error_message: []const u8,

    pub const json_field_names = .{
        .entry_id = "entryId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
