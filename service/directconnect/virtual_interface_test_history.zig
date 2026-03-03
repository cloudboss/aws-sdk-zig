/// Information about the virtual interface failover test.
pub const VirtualInterfaceTestHistory = struct {
    /// The BGP peers that were put in the DOWN state as part of the virtual
    /// interface failover test.
    bgp_peers: ?[]const []const u8 = null,

    /// The time that the virtual interface moves out of the DOWN state.
    end_time: ?i64 = null,

    /// The owner ID of the tested virtual interface.
    owner_account: ?[]const u8 = null,

    /// The time that the virtual interface moves to the DOWN state.
    start_time: ?i64 = null,

    /// The status of the virtual interface failover test.
    status: ?[]const u8 = null,

    /// The time that the virtual interface failover test ran in minutes.
    test_duration_in_minutes: ?i32 = null,

    /// The ID of the virtual interface failover test.
    test_id: ?[]const u8 = null,

    /// The ID of the tested virtual interface.
    virtual_interface_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bgp_peers = "bgpPeers",
        .end_time = "endTime",
        .owner_account = "ownerAccount",
        .start_time = "startTime",
        .status = "status",
        .test_duration_in_minutes = "testDurationInMinutes",
        .test_id = "testId",
        .virtual_interface_id = "virtualInterfaceId",
    };
};
