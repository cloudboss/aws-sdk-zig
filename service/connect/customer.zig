const ParticipantCapabilities = @import("participant_capabilities.zig").ParticipantCapabilities;
const DeviceInfo = @import("device_info.zig").DeviceInfo;

/// Information about the Customer on the contact.
pub const Customer = struct {
    capabilities: ?ParticipantCapabilities,

    /// Information regarding Customer’s device.
    device_info: ?DeviceInfo,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .device_info = "DeviceInfo",
    };
};
