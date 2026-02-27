const HasLogicalRedundancy = @import("has_logical_redundancy.zig").HasLogicalRedundancy;
const InterconnectState = @import("interconnect_state.zig").InterconnectState;
const MacSecKey = @import("mac_sec_key.zig").MacSecKey;
const Tag = @import("tag.zig").Tag;

/// Information about an interconnect.
pub const Interconnect = struct {
    /// The Direct Connect endpoint on which the physical connection terminates.
    aws_device: ?[]const u8,

    /// The Direct Connect endpoint that terminates the physical connection.
    aws_device_v2: ?[]const u8,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8,

    /// The bandwidth of the connection.
    bandwidth: ?[]const u8,

    /// The MAC Security (MACsec) encryption mode.
    ///
    /// The valid values are `no_encrypt`, `should_encrypt`, and `must_encrypt`.
    encryption_mode: ?[]const u8,

    /// Indicates whether the interconnect supports a secondary BGP in the same
    /// address family (IPv4/IPv6).
    has_logical_redundancy: ?HasLogicalRedundancy,

    /// The ID of the interconnect.
    interconnect_id: ?[]const u8,

    /// The name of the interconnect.
    interconnect_name: ?[]const u8,

    /// The state of the interconnect. The following are the possible values:
    ///
    /// * `requested`: The initial state of an interconnect. The interconnect stays
    ///   in the
    /// requested state until the Letter of Authorization (LOA) is sent to the
    /// customer.
    ///
    /// * `pending`: The interconnect is approved, and is being initialized.
    ///
    /// * `available`: The network link is up, and the interconnect is ready for
    ///   use.
    ///
    /// * `down`: The network link is down.
    ///
    /// * `deleting`: The interconnect is being deleted.
    ///
    /// * `deleted`: The interconnect is deleted.
    ///
    /// * `unknown`: The state of the interconnect is not available.
    interconnect_state: ?InterconnectState,

    /// Indicates whether jumbo frames are supported.
    jumbo_frame_capable: ?bool,

    /// The ID of the LAG.
    lag_id: ?[]const u8,

    /// The time of the most recent call to DescribeLoa for this connection.
    loa_issue_time: ?i64,

    /// The location of the connection.
    location: ?[]const u8,

    /// Indicates whether the interconnect supports MAC Security (MACsec).
    mac_sec_capable: ?bool,

    /// The MAC Security (MACsec) security keys.
    mac_sec_keys: ?[]const MacSecKey,

    /// The MAC Security (MACsec) port link status.
    ///
    /// The valid values are `Encryption Up`, which means that there is an active
    /// Connection Key Name, or `Encryption Down`.
    port_encryption_status: ?[]const u8,

    /// The name of the service provider associated with the interconnect.
    provider_name: ?[]const u8,

    /// The Amazon Web Services Region where the connection is located.
    region: ?[]const u8,

    /// The tags associated with the interconnect.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .aws_device = "awsDevice",
        .aws_device_v2 = "awsDeviceV2",
        .aws_logical_device_id = "awsLogicalDeviceId",
        .bandwidth = "bandwidth",
        .encryption_mode = "encryptionMode",
        .has_logical_redundancy = "hasLogicalRedundancy",
        .interconnect_id = "interconnectId",
        .interconnect_name = "interconnectName",
        .interconnect_state = "interconnectState",
        .jumbo_frame_capable = "jumboFrameCapable",
        .lag_id = "lagId",
        .loa_issue_time = "loaIssueTime",
        .location = "location",
        .mac_sec_capable = "macSecCapable",
        .mac_sec_keys = "macSecKeys",
        .port_encryption_status = "portEncryptionStatus",
        .provider_name = "providerName",
        .region = "region",
        .tags = "tags",
    };
};
