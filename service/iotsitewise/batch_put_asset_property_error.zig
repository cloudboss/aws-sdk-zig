const BatchPutAssetPropertyValueErrorCode = @import("batch_put_asset_property_value_error_code.zig").BatchPutAssetPropertyValueErrorCode;
const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains error information from updating a batch of asset property values.
pub const BatchPutAssetPropertyError = struct {
    /// The error code.
    error_code: BatchPutAssetPropertyValueErrorCode,

    /// The associated error message.
    error_message: []const u8,

    /// A list of timestamps for each error, if any.
    timestamps: []const TimeInNanos,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .timestamps = "timestamps",
    };
};
