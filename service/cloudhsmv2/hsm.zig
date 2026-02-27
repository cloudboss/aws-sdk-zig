const HsmState = @import("hsm_state.zig").HsmState;

/// Contains information about a hardware security module (HSM) in an CloudHSM
/// cluster.
pub const Hsm = struct {
    /// The Availability Zone that contains the HSM.
    availability_zone: ?[]const u8,

    /// The identifier (ID) of the cluster that contains the HSM.
    cluster_id: ?[]const u8,

    /// The identifier (ID) of the HSM's elastic network interface (ENI).
    eni_id: ?[]const u8,

    /// The IP address of the HSM's elastic network interface (ENI).
    eni_ip: ?[]const u8,

    /// The IPv6 address (if any) of the HSM's elastic network interface (ENI).
    eni_ip_v6: ?[]const u8,

    /// The HSM's identifier (ID).
    hsm_id: []const u8,

    /// The type of HSM.
    hsm_type: ?[]const u8,

    /// The HSM's state.
    state: ?HsmState,

    /// A description of the HSM's state.
    state_message: ?[]const u8,

    /// The subnet that contains the HSM's elastic network interface (ENI).
    subnet_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .cluster_id = "ClusterId",
        .eni_id = "EniId",
        .eni_ip = "EniIp",
        .eni_ip_v6 = "EniIpV6",
        .hsm_id = "HsmId",
        .hsm_type = "HsmType",
        .state = "State",
        .state_message = "StateMessage",
        .subnet_id = "SubnetId",
    };
};
