const BatchGetAssetPropertyValueErrorCode = @import("batch_get_asset_property_value_error_code.zig").BatchGetAssetPropertyValueErrorCode;

/// Contains error information for an asset property value entry that is
/// associated with the
/// [BatchGetAssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValue.html) API.
pub const BatchGetAssetPropertyValueErrorEntry = struct {
    /// The ID of the entry.
    entry_id: []const u8,

    /// The error code.
    error_code: BatchGetAssetPropertyValueErrorCode,

    /// The associated error message.
    error_message: []const u8,

    pub const json_field_names = .{
        .entry_id = "entryId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
