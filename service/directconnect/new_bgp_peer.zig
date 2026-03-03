const AddressFamily = @import("address_family.zig").AddressFamily;

/// Information about a new BGP peer.
pub const NewBGPPeer = struct {
    /// The address family for the BGP peer.
    address_family: ?AddressFamily = null,

    /// The IP address assigned to the Amazon interface.
    amazon_address: ?[]const u8 = null,

    /// The autonomous system number (ASN). The valid range is from 1 to 2147483646
    /// for Border Gateway Protocol (BGP) configuration. If you provide a number
    /// greater than the maximum, an error is returned. Use `asnLong` instead.
    asn: i32 = 0,

    /// The long ASN for a new BGP peer. The valid range is from 1 to 4294967294.
    asn_long: ?i64 = null,

    /// The authentication key for BGP configuration. This string has a minimum
    /// length of 6 characters and and a maximun lenth of 80 characters.
    auth_key: ?[]const u8 = null,

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .amazon_address = "amazonAddress",
        .asn = "asn",
        .asn_long = "asnLong",
        .auth_key = "authKey",
        .customer_address = "customerAddress",
    };
};
