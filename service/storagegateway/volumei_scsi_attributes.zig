/// Lists iSCSI information about a volume.
pub const VolumeiSCSIAttributes = struct {
    /// Indicates whether mutual CHAP is enabled for the iSCSI target.
    chap_enabled: bool = false,

    /// The logical disk number.
    lun_number: ?i32,

    /// The network interface identifier.
    network_interface_id: ?[]const u8,

    /// The port used to communicate with iSCSI targets.
    network_interface_port: i32 = 0,

    /// The Amazon Resource Name (ARN) of the volume target.
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .chap_enabled = "ChapEnabled",
        .lun_number = "LunNumber",
        .network_interface_id = "NetworkInterfaceId",
        .network_interface_port = "NetworkInterfacePort",
        .target_arn = "TargetARN",
    };
};
