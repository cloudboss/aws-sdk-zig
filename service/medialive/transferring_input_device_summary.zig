const InputDeviceTransferType = @import("input_device_transfer_type.zig").InputDeviceTransferType;

/// Details about the input device that is being transferred.
pub const TransferringInputDeviceSummary = struct {
    /// The unique ID of the input device.
    id: ?[]const u8 = null,

    /// The optional message that the sender has attached to the transfer.
    message: ?[]const u8 = null,

    /// The AWS account ID for the recipient of the input device transfer.
    target_customer_id: ?[]const u8 = null,

    /// The type (direction) of the input device transfer.
    transfer_type: ?InputDeviceTransferType = null,

    pub const json_field_names = .{
        .id = "Id",
        .message = "Message",
        .target_customer_id = "TargetCustomerId",
        .transfer_type = "TransferType",
    };
};
