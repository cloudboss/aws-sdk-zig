const AddressFamily = @import("address_family.zig").AddressFamily;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const Tag = @import("tag.zig").Tag;

/// Information about a public virtual interface to be provisioned on a
/// connection.
pub const NewPublicVirtualInterfaceAllocation = struct {
    /// The address family for the BGP peer.
    address_family: ?AddressFamily,

    /// The IP address assigned to the Amazon interface.
    amazon_address: ?[]const u8,

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
    ///
    /// The valid values are 1-2147483646.
    asn: i32 = 0,

    /// The ASN when allocating a new public virtual interface. The valid range is
    /// from 1 to 4294967294 for BGP configuration.
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

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8,

    /// The routes to be advertised to the Amazon Web Services network in this
    /// Region. Applies to public virtual interfaces.
    route_filter_prefixes: ?[]const RouteFilterPrefix,

    /// The tags associated with the public virtual interface.
    tags: ?[]const Tag,

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
        .route_filter_prefixes = "routeFilterPrefixes",
        .tags = "tags",
        .virtual_interface_name = "virtualInterfaceName",
        .vlan = "vlan",
    };
};
