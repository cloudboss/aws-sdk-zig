const EthernetPayload = @import("ethernet_payload.zig").EthernetPayload;
const NtpPayload = @import("ntp_payload.zig").NtpPayload;

/// The network configuration for a device.
pub const NetworkPayload = struct {
    /// Settings for Ethernet port 0.
    ethernet_0: ?EthernetPayload,

    /// Settings for Ethernet port 1.
    ethernet_1: ?EthernetPayload,

    /// Network time protocol (NTP) server settings.
    ntp: ?NtpPayload,

    pub const json_field_names = .{
        .ethernet_0 = "Ethernet0",
        .ethernet_1 = "Ethernet1",
        .ntp = "Ntp",
    };
};
