const AddressFamily = @import("address_family.zig").AddressFamily;
const BGPPeer = @import("bgp_peer.zig").BGPPeer;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const Tag = @import("tag.zig").Tag;
const VirtualInterfaceState = @import("virtual_interface_state.zig").VirtualInterfaceState;

/// Information about a virtual interface.
pub const VirtualInterface = struct {
    /// The address family for the BGP peer.
    address_family: ?AddressFamily = null,

    /// The IP address assigned to the Amazon interface.
    amazon_address: ?[]const u8 = null,

    /// The autonomous system number (AS) for the Amazon side of the connection.
    amazon_side_asn: ?i64 = null,

    /// The autonomous system number (ASN). The valid range is from 1 to 2147483646
    /// for Border Gateway Protocol (BGP) configuration. If you provide a number
    /// greater than the maximum, an error is returned. Use `asnLong` instead.
    ///
    /// * You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    ///   as it supports a greater pool of numbers.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    ///
    /// * If you enter a 4-byte ASN for the `asn` parameter, the API returns an
    ///   error.
    ///
    /// * If you are using a 2-byte ASN, the API response will include the
    /// 2-byte value for both the `asn` and `asnLong` fields.
    asn: i32 = 0,

    /// The long ASN for the virtual interface. The valid range is from 1 to
    /// 4294967294 for BGP configuration.
    ///
    /// Note the following limitations when using `asnLong`:
    ///
    /// * You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    ///   as it supports a greater pool of numbers.
    ///
    /// * `asnLong` accepts any valid ASN value, regardless if it's 2-byte or
    ///   4-byte.
    ///
    /// * When using a 4-byte `asnLong`, the API response returns `0` for the legacy
    ///   `asn` attribute since 4-byte ASN values exceed the maximum supported value
    ///   of 2,147,483,647.
    ///
    /// * If you are using a 2-byte ASN, the API response will include the
    /// 2-byte value for both the `asn` and `asnLong` fields.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    asn_long: ?i64 = null,

    /// The authentication key for BGP configuration. This string has a minimum
    /// length of 6 characters and and a maximun lenth of 80 characters.
    auth_key: ?[]const u8 = null,

    /// The Direct Connect endpoint that terminates the physical connection.
    aws_device_v2: ?[]const u8 = null,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8 = null,

    /// The BGP peers configured on this virtual interface.
    bgp_peers: ?[]const BGPPeer = null,

    /// The ID of the connection.
    connection_id: ?[]const u8 = null,

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8 = null,

    /// The customer router configuration.
    customer_router_config: ?[]const u8 = null,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8 = null,

    /// Indicates whether jumbo frames are supported.
    jumbo_frame_capable: ?bool = null,

    /// The location of the connection.
    location: ?[]const u8 = null,

    /// The maximum transmission unit (MTU), in bytes. The supported values are 1500
    /// and 8500. The default value is 1500
    mtu: ?i32 = null,

    /// The ID of the Amazon Web Services account that owns the virtual interface.
    owner_account: ?[]const u8 = null,

    /// The number of inbound IPv4 route prefixes allocated to the virtual
    /// interface. Not applicable to public virtual interfaces.
    prefix_pool_allocated_count_ipv_4: ?i32 = null,

    /// The number of inbound IPv6 route prefixes allocated to the virtual
    /// interface. Not applicable to public virtual interfaces.
    prefix_pool_allocated_count_ipv_6: ?i32 = null,

    /// The rate limit (bandwidth allocation) applied to the virtual interface. The
    /// value must be one of the supported bandwidth values and cannot exceed the
    /// bandwidth of the parent connection or LAG. Supported values: `50Mbps`,
    /// `100Mbps`, `200Mbps`, `300Mbps`, `400Mbps`, `500Mbps`, `600Mbps`, `700Mbps`,
    /// `800Mbps`, `900Mbps`, `1Gbps`, `1.2Gbps`, `1.5Gbps`, `1.8Gbps`, `2Gbps`,
    /// `2.1Gbps`, `2.4Gbps`, `2.7Gbps`, `3Gbps`, `3.2Gbps`, `3.6Gbps`, `4Gbps`,
    /// `5Gbps`, `6Gbps`, `7Gbps`, `8Gbps`, `9Gbps`, `10Gbps`, `12Gbps`, `15Gbps`,
    /// `18Gbps`, `20Gbps`, `21Gbps`, `24Gbps`, `27Gbps`, `30Gbps`, `32Gbps`,
    /// `36Gbps`, `40Gbps`, `50Gbps`, `60Gbps`, `70Gbps`, `80Gbps`, `100Gbps`,
    /// `120Gbps`, `150Gbps`, `180Gbps`, `200Gbps`, `210Gbps`, `240Gbps`, `270Gbps`,
    /// `300Gbps`, `320Gbps`, `360Gbps`, `400Gbps`, `450Gbps`, `480Gbps`, `500Gbps`,
    /// `540Gbps`, `600Gbps`, `700Gbps`, `800Gbps`, `900Gbps`, `1Tbps`, `1.1Tbps`,
    /// `1.2Tbps`, `1.3Tbps`, `1.4Tbps`, `1.5Tbps`, `1.6Tbps`.
    rate_limit: ?[]const u8 = null,

    /// The Amazon Web Services Region where the virtual interface is located.
    region: ?[]const u8 = null,

    /// The routes to be advertised to the Amazon Web Services network in this
    /// Region. Applies to public virtual interfaces.
    route_filter_prefixes: ?[]const RouteFilterPrefix = null,

    /// Indicates whether SiteLink is enabled.
    site_link_enabled: ?bool = null,

    /// The tags associated with the virtual interface.
    tags: ?[]const Tag = null,

    /// The ID of the virtual private gateway. Applies only to private virtual
    /// interfaces.
    virtual_gateway_id: ?[]const u8 = null,

    /// The ID of the virtual interface.
    virtual_interface_id: ?[]const u8 = null,

    /// The name of the virtual interface assigned by the customer network. The name
    /// has a maximum of 100 characters. The following are valid characters: a-z,
    /// 0-9 and a hyphen (-).
    virtual_interface_name: ?[]const u8 = null,

    /// The state of the virtual interface. The following are the possible values:
    ///
    /// * `confirming`: The creation of the virtual interface is pending
    ///   confirmation from the virtual interface owner. If the owner of the virtual
    ///   interface is different from the owner of the connection on which it is
    ///   provisioned, then the virtual interface will remain in this state until it
    ///   is confirmed by the virtual interface owner.
    ///
    /// * `verifying`: This state only applies to public virtual interfaces. Each
    ///   public virtual interface needs validation before the virtual interface can
    ///   be created.
    ///
    /// * `pending`: A virtual interface is in this state from the time that it is
    ///   created until the virtual interface is ready to forward traffic.
    ///
    /// * `available`: A virtual interface that is able to forward traffic.
    ///
    /// * `down`: A virtual interface that is BGP down.
    ///
    /// * `testing`: A virtual interface is in this state immediately after calling
    ///   StartBgpFailoverTest and remains in this state during the duration of the
    ///   test.
    ///
    /// * `deleting`: A virtual interface is in this state immediately after calling
    ///   DeleteVirtualInterface until it can no longer forward traffic.
    ///
    /// * `deleted`: A virtual interface that cannot forward traffic.
    ///
    /// * `rejected`: The virtual interface owner has declined creation of the
    ///   virtual interface. If a virtual interface in the `Confirming` state is
    ///   deleted by the virtual interface owner, the virtual interface enters the
    ///   `Rejected` state.
    ///
    /// * `unknown`: The state of the virtual interface is not available.
    virtual_interface_state: ?VirtualInterfaceState = null,

    /// The type of virtual interface. The possible values are `private`, `public`
    /// and `transit`.
    virtual_interface_type: ?[]const u8 = null,

    /// The ID of the VLAN.
    vlan: i32 = 0,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .amazon_address = "amazonAddress",
        .amazon_side_asn = "amazonSideAsn",
        .asn = "asn",
        .asn_long = "asnLong",
        .auth_key = "authKey",
        .aws_device_v2 = "awsDeviceV2",
        .aws_logical_device_id = "awsLogicalDeviceId",
        .bgp_peers = "bgpPeers",
        .connection_id = "connectionId",
        .customer_address = "customerAddress",
        .customer_router_config = "customerRouterConfig",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .jumbo_frame_capable = "jumboFrameCapable",
        .location = "location",
        .mtu = "mtu",
        .owner_account = "ownerAccount",
        .prefix_pool_allocated_count_ipv_4 = "prefixPoolAllocatedCountIpv4",
        .prefix_pool_allocated_count_ipv_6 = "prefixPoolAllocatedCountIpv6",
        .rate_limit = "rateLimit",
        .region = "region",
        .route_filter_prefixes = "routeFilterPrefixes",
        .site_link_enabled = "siteLinkEnabled",
        .tags = "tags",
        .virtual_gateway_id = "virtualGatewayId",
        .virtual_interface_id = "virtualInterfaceId",
        .virtual_interface_name = "virtualInterfaceName",
        .virtual_interface_state = "virtualInterfaceState",
        .virtual_interface_type = "virtualInterfaceType",
        .vlan = "vlan",
    };
};
