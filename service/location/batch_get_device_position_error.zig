const BatchItemError = @import("batch_item_error.zig").BatchItemError;

/// Contains error details for each device that didn't return a position.
pub const BatchGetDevicePositionError = struct {
    /// The ID of the device that didn't return a position.
    device_id: []const u8,

    /// Contains details related to the error code.
    @"error": BatchItemError,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .@"error" = "Error",
    };
};
