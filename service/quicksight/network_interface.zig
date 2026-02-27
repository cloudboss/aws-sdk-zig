const NetworkInterfaceStatus = @import("network_interface_status.zig").NetworkInterfaceStatus;

/// The structure that contains information about a network interface.
pub const NetworkInterface = struct {
    /// The availability zone that the network interface resides in.
    availability_zone: ?[]const u8,

    /// An error message.
    error_message: ?[]const u8,

    /// The network interface ID.
    network_interface_id: ?[]const u8,

    /// The status of the network interface.
    status: ?NetworkInterfaceStatus,

    /// The subnet ID associated with the network interface.
    subnet_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .error_message = "ErrorMessage",
        .network_interface_id = "NetworkInterfaceId",
        .status = "Status",
        .subnet_id = "SubnetId",
    };
};
