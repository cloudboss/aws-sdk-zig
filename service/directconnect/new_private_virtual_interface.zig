const AddressFamily = @import("address_family.zig").AddressFamily;
const Tag = @import("tag.zig").Tag;

/// Information about a private virtual interface.
pub const NewPrivateVirtualInterface = struct {
    /// The address family for the BGP peer.
    address_family: ?AddressFamily = null,

    /// The IP address assigned to the Amazon interface.
    amazon_address: ?[]const u8 = null,

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
    ///
    /// The valid values are 1-2147483646.
    asn: i32 = 0,

    /// The long ASN for a new private virtual interface. The valid range is from 1
    /// to 4294967294 for BGP configuration.
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

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8 = null,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8 = null,

    /// Indicates whether to enable or disable SiteLink.
    enable_site_link: ?bool = null,

    /// The maximum transmission unit (MTU), in bytes. The supported values are 1500
    /// and 8500. The default value is 1500.
    mtu: ?i32 = null,

    /// The number of inbound IPv4 route prefixes to allocate to the virtual
    /// interface.
    prefix_pool_allocated_count_ipv_4: ?i32 = null,

    /// The number of inbound IPv6 route prefixes to allocate to the virtual
    /// interface.
    prefix_pool_allocated_count_ipv_6: ?i32 = null,

    /// The rate limit (bandwidth allocation) to apply to the virtual interface. The
    /// rate limit restricts the maximum bandwidth that the virtual interface can
    /// use on the parent connection.
    rate_limit: ?[]const u8 = null,

    /// The tags associated with the private virtual interface.
    tags: ?[]const Tag = null,

    /// The ID of the virtual private gateway.
    virtual_gateway_id: ?[]const u8 = null,

    /// The name of the virtual interface assigned by the customer network. The name
    /// has a maximum of 100 characters. The following are valid characters: a-z,
    /// 0-9 and a hyphen (-).
    virtual_interface_name: []const u8,

    /// The ID of the VLAN.
    vlan: i32 = 0,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .amazon_address = "amazonAddress",
        .asn = "asn",
        .asn_long = "asnLong",
        .auth_key = "authKey",
        .customer_address = "customerAddress",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .enable_site_link = "enableSiteLink",
        .mtu = "mtu",
        .prefix_pool_allocated_count_ipv_4 = "prefixPoolAllocatedCountIpv4",
        .prefix_pool_allocated_count_ipv_6 = "prefixPoolAllocatedCountIpv6",
        .rate_limit = "rateLimit",
        .tags = "tags",
        .virtual_gateway_id = "virtualGatewayId",
        .virtual_interface_name = "virtualInterfaceName",
        .vlan = "vlan",
    };
};
