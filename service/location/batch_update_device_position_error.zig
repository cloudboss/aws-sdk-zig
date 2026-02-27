const BatchItemError = @import("batch_item_error.zig").BatchItemError;

/// Contains error details for each device that failed to update its position.
pub const BatchUpdateDevicePositionError = struct {
    /// The device associated with the failed location update.
    device_id: []const u8,

    /// Contains details related to the error code such as the error code and error
    /// message.
    @"error": BatchItemError,

    /// The timestamp at which the device position was determined. Uses [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .@"error" = "Error",
        .sample_time = "SampleTime",
    };
};
