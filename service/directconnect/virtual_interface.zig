const AddressFamily = @import("address_family.zig").AddressFamily;
const BGPPeer = @import("bgp_peer.zig").BGPPeer;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const Tag = @import("tag.zig").Tag;
const VirtualInterfaceState = @import("virtual_interface_state.zig").VirtualInterfaceState;

/// Information about a virtual interface.
pub const VirtualInterface = struct {
    /// The address family for the BGP peer.
    address_family: ?AddressFamily,

    /// The IP address assigned to the Amazon interface.
    amazon_address: ?[]const u8,

    /// The autonomous system number (AS) for the Amazon side of the connection.
    amazon_side_asn: ?i64,

    /// The autonomous system number (ASN). The valid range is from 1 to 2147483646
    /// for Border Gateway Protocol (BGP) configuration. If you provide a number
    /// greater than the maximum, an error is returned. Use `asnLong` instead.
    ///
    /// You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    /// as it supports a greater pool of numbers.
    ///
    /// * The `asnLong` attribute accepts both ASN and long ASN
    /// ranges.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    asn: i32 = 0,

    /// The long ASN for the virtual interface. The valid range is from 1 to
    /// 4294967294 for BGP configuration.
    ///
    /// You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    /// as it supports a greater pool of numbers.
    ///
    /// * The `asnLong` attribute accepts both ASN and long ASN
    /// ranges.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    asn_long: ?i64,

    /// The authentication key for BGP configuration. This string has a minimum
    /// length of 6 characters and and a maximun lenth of 80 characters.
    auth_key: ?[]const u8,

    /// The Direct Connect endpoint that terminates the physical connection.
    aws_device_v2: ?[]const u8,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8,

    /// The BGP peers configured on this virtual interface.
    bgp_peers: ?[]const BGPPeer,

    /// The ID of the connection.
    connection_id: ?[]const u8,

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8,

    /// The customer router configuration.
    customer_router_config: ?[]const u8,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8,

    /// Indicates whether jumbo frames are supported.
    jumbo_frame_capable: ?bool,

    /// The location of the connection.
    location: ?[]const u8,

    /// The maximum transmission unit (MTU), in bytes. The supported values are 1500
    /// and 8500. The default value is 1500
    mtu: ?i32,

    /// The ID of the Amazon Web Services account that owns the virtual interface.
    owner_account: ?[]const u8,

    /// The Amazon Web Services Region where the virtual interface is located.
    region: ?[]const u8,

    /// The routes to be advertised to the Amazon Web Services network in this
    /// Region. Applies to public virtual interfaces.
    route_filter_prefixes: ?[]const RouteFilterPrefix,

    /// Indicates whether SiteLink is enabled.
    site_link_enabled: ?bool,

    /// The tags associated with the virtual interface.
    tags: ?[]const Tag,

    /// The ID of the virtual private gateway. Applies only to private virtual
    /// interfaces.
    virtual_gateway_id: ?[]const u8,

    /// The ID of the virtual interface.
    virtual_interface_id: ?[]const u8,

    /// The name of the virtual interface assigned by the customer network. The name
    /// has a maximum of 100 characters. The following are valid characters: a-z,
    /// 0-9 and a hyphen (-).
    virtual_interface_name: ?[]const u8,

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
    virtual_interface_state: ?VirtualInterfaceState,

    /// The type of virtual interface. The possible values are `private`, `public`
    /// and `transit`.
    virtual_interface_type: ?[]const u8,

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
