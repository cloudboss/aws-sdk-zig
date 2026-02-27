const BatchItemError = @import("batch_item_error.zig").BatchItemError;

/// Contains the tracker resource details.
pub const BatchDeleteDevicePositionHistoryError = struct {
    /// The ID of the device for this position.
    device_id: []const u8,

    @"error": BatchItemError,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .@"error" = "Error",
    };
};
