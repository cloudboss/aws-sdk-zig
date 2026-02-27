const EthernetStatus = @import("ethernet_status.zig").EthernetStatus;
const NtpStatus = @import("ntp_status.zig").NtpStatus;

/// The network status of a device.
pub const NetworkStatus = struct {
    /// The status of Ethernet port 0.
    ethernet_0_status: ?EthernetStatus,

    /// The status of Ethernet port 1.
    ethernet_1_status: ?EthernetStatus,

    /// When the network status changed.
    last_updated_time: ?i64,

    /// Details about a network time protocol (NTP) server connection.
    ntp_status: ?NtpStatus,

    pub const json_field_names = .{
        .ethernet_0_status = "Ethernet0Status",
        .ethernet_1_status = "Ethernet1Status",
        .last_updated_time = "LastUpdatedTime",
        .ntp_status = "NtpStatus",
    };
};
