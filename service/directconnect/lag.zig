const Connection = @import("connection.zig").Connection;
const HasLogicalRedundancy = @import("has_logical_redundancy.zig").HasLogicalRedundancy;
const LagState = @import("lag_state.zig").LagState;
const MacSecKey = @import("mac_sec_key.zig").MacSecKey;
const Tag = @import("tag.zig").Tag;

/// Information about a link aggregation group (LAG).
pub const Lag = struct {
    /// Indicates whether the LAG can host other connections.
    allows_hosted_connections: bool = false,

    /// The Direct Connect endpoint that hosts the LAG.
    aws_device: ?[]const u8,

    /// The Direct Connect endpoint that hosts the LAG.
    aws_device_v2: ?[]const u8,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8,

    /// The connections bundled by the LAG.
    connections: ?[]const Connection,

    /// The individual bandwidth of the physical connections bundled by the LAG. The
    /// possible
    /// values are 1Gbps, 10Gbps, 100Gbps, or 400 Gbps..
    connections_bandwidth: ?[]const u8,

    /// The LAG MAC Security (MACsec) encryption mode.
    ///
    /// The valid values are `no_encrypt`, `should_encrypt`, and `must_encrypt`.
    encryption_mode: ?[]const u8,

    /// Indicates whether the LAG supports a secondary BGP peer in the same address
    /// family (IPv4/IPv6).
    has_logical_redundancy: ?HasLogicalRedundancy,

    /// Indicates whether jumbo frames are supported.
    jumbo_frame_capable: ?bool,

    /// The ID of the LAG.
    lag_id: ?[]const u8,

    /// The name of the LAG.
    lag_name: ?[]const u8,

    /// The state of the LAG. The following are the possible values:
    ///
    /// * `requested`: The initial state of a LAG. The LAG stays in the
    /// requested state until the Letter of Authorization (LOA) is available.
    ///
    /// * `pending`: The LAG has been approved and is being initialized.
    ///
    /// * `available`: The network link is established and the LAG is ready for use.
    ///
    /// * `down`: The network link is down.
    ///
    /// * `deleting`: The LAG is being deleted.
    ///
    /// * `deleted`: The LAG is deleted.
    ///
    /// * `unknown`: The state of the LAG is not available.
    lag_state: ?LagState,

    /// The location of the LAG.
    location: ?[]const u8,

    /// Indicates whether the LAG supports MAC Security (MACsec).
    mac_sec_capable: ?bool,

    /// The MAC Security (MACsec) security keys associated with the LAG.
    mac_sec_keys: ?[]const MacSecKey,

    /// The minimum number of physical dedicated connections that must be
    /// operational for the LAG itself to be operational.
    minimum_links: i32 = 0,

    /// The number of physical dedicated connections initially provisioned and
    /// bundled by the LAG.
    /// You can have a maximum of four connections when the port speed is 1 Gbps or
    /// 10 Gbps, or two
    /// when the port speed is 100 Gbps or 400 Gbps.
    number_of_connections: i32 = 0,

    /// The ID of the Amazon Web Services account that owns the LAG.
    owner_account: ?[]const u8,

    /// The name of the service provider associated with the LAG.
    provider_name: ?[]const u8,

    /// The Amazon Web Services Region where the connection is located.
    region: ?[]const u8,

    /// The tags associated with the LAG.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .allows_hosted_connections = "allowsHostedConnections",
        .aws_device = "awsDevice",
        .aws_device_v2 = "awsDeviceV2",
        .aws_logical_device_id = "awsLogicalDeviceId",
        .connections = "connections",
        .connections_bandwidth = "connectionsBandwidth",
        .encryption_mode = "encryptionMode",
        .has_logical_redundancy = "hasLogicalRedundancy",
        .jumbo_frame_capable = "jumboFrameCapable",
        .lag_id = "lagId",
        .lag_name = "lagName",
        .lag_state = "lagState",
        .location = "location",
        .mac_sec_capable = "macSecCapable",
        .mac_sec_keys = "macSecKeys",
        .minimum_links = "minimumLinks",
        .number_of_connections = "numberOfConnections",
        .owner_account = "ownerAccount",
        .provider_name = "providerName",
        .region = "region",
        .tags = "tags",
    };
};
