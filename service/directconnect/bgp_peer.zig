const AddressFamily = @import("address_family.zig").AddressFamily;
const BGPPeerState = @import("bgp_peer_state.zig").BGPPeerState;
const BGPStatus = @import("bgp_status.zig").BGPStatus;

/// Information about a BGP peer.
pub const BGPPeer = struct {
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
    asn: i32 = 0,

    /// The long ASN for the BGP peer. The valid range is from 1 to 4294967294 for
    /// BGP configuration.
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

    /// The Direct Connect endpoint that terminates the BGP peer.
    aws_device_v2: ?[]const u8,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8,

    /// The ID of the BGP peer.
    bgp_peer_id: ?[]const u8,

    /// The state of the BGP peer. The following are the possible values:
    ///
    /// * `verifying`: The BGP peering addresses or ASN require validation before
    ///   the BGP peer can be created. This state applies only to public virtual
    ///   interfaces.
    ///
    /// * `pending`: The BGP peer is created, and remains in this state until it is
    ///   ready to be established.
    ///
    /// * `available`: The BGP peer is ready to be established.
    ///
    /// * `deleting`: The BGP peer is being deleted.
    ///
    /// * `deleted`: The BGP peer is deleted and cannot be established.
    bgp_peer_state: ?BGPPeerState,

    /// The status of the BGP peer. The following are the possible values:
    ///
    /// * `up`: The BGP peer is established. This state does not indicate the
    /// state of the routing function. Ensure that you are receiving routes over the
    /// BGP session.
    ///
    /// * `down`: The BGP peer is down.
    ///
    /// * `unknown`: The BGP peer status is not available.
    bgp_status: ?BGPStatus,

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .amazon_address = "amazonAddress",
        .asn = "asn",
        .asn_long = "asnLong",
        .auth_key = "authKey",
        .aws_device_v2 = "awsDeviceV2",
        .aws_logical_device_id = "awsLogicalDeviceId",
        .bgp_peer_id = "bgpPeerId",
        .bgp_peer_state = "bgpPeerState",
        .bgp_status = "bgpStatus",
        .customer_address = "customerAddress",
    };
};
