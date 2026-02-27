const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpSet = @import("ip_set.zig").IpSet;
const CustomRoutingAcceleratorStatus = @import("custom_routing_accelerator_status.zig").CustomRoutingAcceleratorStatus;

/// Attributes of a custom routing accelerator.
pub const CustomRoutingAccelerator = struct {
    /// The Amazon Resource Name (ARN) of the custom routing accelerator.
    accelerator_arn: ?[]const u8,

    /// The date and time that the accelerator was created.
    created_time: ?i64,

    /// The Domain Name System (DNS) name that Global Accelerator creates that
    /// points to an accelerator's static IPv4 addresses.
    ///
    /// The naming convention for the DNS name is the following: A lowercase letter
    /// a,
    /// followed by a 16-bit random hex string, followed by
    /// .awsglobalaccelerator.com. For example:
    /// a1234567890abcdef.awsglobalaccelerator.com.
    ///
    /// If you have a dual-stack accelerator, you also have a second DNS name,
    /// `DualStackDnsName`, that points to both the A record
    /// and the AAAA record for all four static addresses for the accelerator: two
    /// IPv4 addresses and two IPv6 addresses.
    ///
    /// For more information about the default DNS name, see [
    /// Support for DNS addressing in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/dns-addressing-custom-domains.dns-addressing.html) in the *Global Accelerator Developer Guide*.
    dns_name: ?[]const u8,

    /// Indicates whether the accelerator is enabled. The value is true or false.
    /// The default value is true.
    ///
    /// If the value is set to true, the accelerator cannot be deleted. If set to
    /// false, accelerator can be deleted.
    enabled: ?bool,

    /// The IP address type that an accelerator supports. For a custom routing
    /// accelerator, the value must be IPV4.
    ip_address_type: ?IpAddressType,

    /// The static IP addresses that Global Accelerator associates with the
    /// accelerator.
    ip_sets: ?[]const IpSet,

    /// The date and time that the accelerator was last modified.
    last_modified_time: ?i64,

    /// The name of the accelerator. The name must contain only alphanumeric
    /// characters or
    /// hyphens (-), and must not begin or end with a hyphen.
    name: ?[]const u8,

    /// Describes the deployment status of the accelerator.
    status: ?CustomRoutingAcceleratorStatus,

    pub const json_field_names = .{
        .accelerator_arn = "AcceleratorArn",
        .created_time = "CreatedTime",
        .dns_name = "DnsName",
        .enabled = "Enabled",
        .ip_address_type = "IpAddressType",
        .ip_sets = "IpSets",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};
