const AsnAssociation = @import("asn_association.zig").AsnAssociation;
const ByoipCidrState = @import("byoip_cidr_state.zig").ByoipCidrState;

/// Information about an address range that is provisioned for use with your
/// Amazon Web Services resources
/// through bring your own IP addresses (BYOIP).
pub const ByoipCidr = struct {
    /// Specifies the advertisement method for the BYOIP CIDR. Valid values are:
    ///
    /// * `unicast`: IP is advertised from a single location (regional services like
    ///   EC2)
    ///
    /// * `anycast`: IP is advertised from multiple global locations simultaneously
    ///   (global services like CloudFront)
    ///
    /// For more information, see [Bring your own IP to CloudFront using
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoip-cloudfront.html) in the *Amazon VPC IPAM User Guide*.
    advertisement_type: ?[]const u8,

    /// The BYOIP CIDR associations with ASNs.
    asn_associations: ?[]const AsnAssociation,

    /// The address range, in CIDR notation.
    cidr: ?[]const u8,

    /// The description of the address range.
    description: ?[]const u8,

    /// If you have [Local
    /// Zones](https://docs.aws.amazon.com/local-zones/latest/ug/how-local-zones-work.html) enabled, you can choose a network border group for Local Zones when you provision and advertise a BYOIPv4 CIDR. Choose the network border group carefully as the EIP and the Amazon Web Services resource it is associated with must reside in the same network border group.
    ///
    /// You can provision BYOIP address ranges to and advertise them in the
    /// following Local Zone network border groups:
    ///
    /// * us-east-1-dfw-2
    ///
    /// * us-west-2-lax-1
    ///
    /// * us-west-2-phx-2
    ///
    /// You cannot provision or advertise BYOIPv6 address ranges in Local Zones at
    /// this time.
    network_border_group: ?[]const u8,

    /// The state of the address range.
    ///
    /// * `advertised`: The address range is being advertised to the internet by
    ///   Amazon Web Services.
    ///
    /// * `deprovisioned`: The address range is deprovisioned.
    ///
    /// * `failed-deprovision`: The request to deprovision the address range was
    ///   unsuccessful. Ensure that all EIPs from the range have been deallocated
    ///   and try again.
    ///
    /// * `failed-provision`: The request to provision the address range was
    ///   unsuccessful.
    ///
    /// * `pending-deprovision`: You’ve submitted a request to deprovision an
    ///   address range and it's pending.
    ///
    /// * `pending-provision`: You’ve submitted a request to provision an address
    ///   range and it's pending.
    ///
    /// * `provisioned`: The address range is provisioned and can be advertised. The
    ///   range is not currently advertised.
    ///
    /// * `provisioned-not-publicly-advertisable`: The address range is provisioned
    ///   and cannot be advertised.
    state: ?ByoipCidrState,

    /// Upon success, contains the ID of the address pool. Otherwise, contains an
    /// error message.
    status_message: ?[]const u8,
};
