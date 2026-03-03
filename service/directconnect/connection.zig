const ConnectionState = @import("connection_state.zig").ConnectionState;
const HasLogicalRedundancy = @import("has_logical_redundancy.zig").HasLogicalRedundancy;
const MacSecKey = @import("mac_sec_key.zig").MacSecKey;
const Tag = @import("tag.zig").Tag;

/// Information about an Direct Connect connection.
pub const Connection = struct {
    /// The Direct Connect endpoint on which the physical connection terminates.
    aws_device: ?[]const u8 = null,

    /// The Direct Connect endpoint that terminates the physical connection.
    aws_device_v2: ?[]const u8 = null,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8 = null,

    /// The bandwidth of the connection.
    bandwidth: ?[]const u8 = null,

    /// The ID of the connection.
    connection_id: ?[]const u8 = null,

    /// The name of the connection.
    connection_name: ?[]const u8 = null,

    /// The state of the connection. The following are the possible values:
    ///
    /// * `ordering`: The initial state of a hosted connection provisioned on an
    ///   interconnect. The connection stays in the ordering state until the owner
    ///   of the hosted connection confirms or declines the connection order.
    ///
    /// * `requested`: The initial state of a standard connection. The connection
    ///   stays in the requested state until the Letter of Authorization (LOA) is
    ///   sent to the customer.
    ///
    /// * `pending`: The connection has been approved and is being initialized.
    ///
    /// * `available`: The network link is up and the connection is ready for use.
    ///
    /// * `down`: The network link is down.
    ///
    /// * `deleting`: The connection is being deleted.
    ///
    /// * `deleted`: The connection has been deleted.
    ///
    /// * `rejected`: A hosted connection in the `ordering` state enters the
    ///   `rejected` state if it is deleted by the customer.
    ///
    /// * `unknown`: The state of the connection is not available.
    connection_state: ?ConnectionState = null,

    /// The MAC Security (MACsec) connection encryption mode.
    ///
    /// The valid values are `no_encrypt`, `should_encrypt`, and `must_encrypt`.
    encryption_mode: ?[]const u8 = null,

    /// Indicates whether the connection supports a secondary BGP peer in the same
    /// address family (IPv4/IPv6).
    has_logical_redundancy: ?HasLogicalRedundancy = null,

    /// Indicates whether jumbo frames are supported.
    jumbo_frame_capable: ?bool = null,

    /// The ID of the LAG.
    lag_id: ?[]const u8 = null,

    /// The time of the most recent call to DescribeLoa for this connection.
    loa_issue_time: ?i64 = null,

    /// The location of the connection.
    location: ?[]const u8 = null,

    /// Indicates whether the connection supports MAC Security (MACsec).
    mac_sec_capable: ?bool = null,

    /// The MAC Security (MACsec) security keys associated with the connection.
    mac_sec_keys: ?[]const MacSecKey = null,

    /// The ID of the Amazon Web Services account that owns the connection.
    owner_account: ?[]const u8 = null,

    /// Indicates whether the interconnect hosting this connection supports MAC
    /// Security (MACsec).
    partner_interconnect_mac_sec_capable: ?bool = null,

    /// The name of the Direct Connect service provider associated with the
    /// connection.
    partner_name: ?[]const u8 = null,

    /// The MAC Security (MACsec) port link status of the connection.
    ///
    /// The valid values are `Encryption Up`, which means that there is an active
    /// Connection Key Name, or `Encryption Down`.
    port_encryption_status: ?[]const u8 = null,

    /// The name of the service provider associated with the connection.
    provider_name: ?[]const u8 = null,

    /// The Amazon Web Services Region where the connection is located.
    region: ?[]const u8 = null,

    /// The tags associated with the connection.
    tags: ?[]const Tag = null,

    /// The ID of the VLAN.
    vlan: i32 = 0,

    pub const json_field_names = .{
        .aws_device = "awsDevice",
        .aws_device_v2 = "awsDeviceV2",
        .aws_logical_device_id = "awsLogicalDeviceId",
        .bandwidth = "bandwidth",
        .connection_id = "connectionId",
        .connection_name = "connectionName",
        .connection_state = "connectionState",
        .encryption_mode = "encryptionMode",
        .has_logical_redundancy = "hasLogicalRedundancy",
        .jumbo_frame_capable = "jumboFrameCapable",
        .lag_id = "lagId",
        .loa_issue_time = "loaIssueTime",
        .location = "location",
        .mac_sec_capable = "macSecCapable",
        .mac_sec_keys = "macSecKeys",
        .owner_account = "ownerAccount",
        .partner_interconnect_mac_sec_capable = "partnerInterconnectMacSecCapable",
        .partner_name = "partnerName",
        .port_encryption_status = "portEncryptionStatus",
        .provider_name = "providerName",
        .region = "region",
        .tags = "tags",
        .vlan = "vlan",
    };
};
