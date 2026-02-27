/// Lists iSCSI information about a VTL device.
pub const DeviceiSCSIAttributes = struct {
    /// Indicates whether mutual CHAP is enabled for the iSCSI target.
    chap_enabled: bool = false,

    /// The network interface identifier of the VTL device.
    network_interface_id: ?[]const u8,

    /// The port used to communicate with iSCSI VTL device targets.
    network_interface_port: i32 = 0,

    /// Specifies the unique Amazon Resource Name (ARN) that encodes the iSCSI
    /// qualified
    /// name(iqn) of a tape drive or media changer target.
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .chap_enabled = "ChapEnabled",
        .network_interface_id = "NetworkInterfaceId",
        .network_interface_port = "NetworkInterfacePort",
        .target_arn = "TargetARN",
    };
};
