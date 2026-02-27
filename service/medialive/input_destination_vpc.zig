/// The properties for a VPC type input destination.
pub const InputDestinationVpc = struct {
    /// The availability zone of the Input destination.
    availability_zone: ?[]const u8,

    /// The network interface ID of the Input destination in the VPC.
    network_interface_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .network_interface_id = "NetworkInterfaceId",
    };
};
