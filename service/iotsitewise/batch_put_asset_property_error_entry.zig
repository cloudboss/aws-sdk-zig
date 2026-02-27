const BatchPutAssetPropertyError = @import("batch_put_asset_property_error.zig").BatchPutAssetPropertyError;

/// Contains error information for asset property value entries that are
/// associated with the
/// [BatchPutAssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchPutAssetPropertyValue.html) API.
pub const BatchPutAssetPropertyErrorEntry = struct {
    /// The ID of the failed entry.
    entry_id: []const u8,

    /// The list of update property value errors.
    errors: []const BatchPutAssetPropertyError,

    pub const json_field_names = .{
        .entry_id = "entryId",
        .errors = "errors",
    };
};
