const Device = @import("device.zig").Device;
const IncompatibilityMessage = @import("incompatibility_message.zig").IncompatibilityMessage;

/// Represents a device pool compatibility result.
pub const DevicePoolCompatibilityResult = struct {
    /// Whether the result was compatible with the device pool.
    compatible: ?bool,

    /// The device (phone or tablet) to return information about.
    device: ?Device,

    /// Information about the compatibility.
    incompatibility_messages: ?[]const IncompatibilityMessage,

    pub const json_field_names = .{
        .compatible = "compatible",
        .device = "device",
        .incompatibility_messages = "incompatibilityMessages",
    };
};
