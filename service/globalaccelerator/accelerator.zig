const AcceleratorEvent = @import("accelerator_event.zig").AcceleratorEvent;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpSet = @import("ip_set.zig").IpSet;
const AcceleratorStatus = @import("accelerator_status.zig").AcceleratorStatus;

/// An accelerator is a complex type that includes one or more listeners that
/// process inbound connections and then direct
/// traffic to one or more endpoint groups, each of which includes endpoints,
/// such as load balancers.
pub const Accelerator = struct {
    /// The Amazon Resource Name (ARN) of the accelerator.
    accelerator_arn: ?[]const u8,

    /// The date and time that the accelerator was created.
    created_time: ?i64,

    /// The Domain Name System (DNS) name that Global Accelerator creates that
    /// points to an accelerator's static IPv4 addresses.
    ///
    /// The naming convention for the DNS name for an accelerator is the following:
    /// A lowercase letter a,
    /// followed by a 16-bit random hex string, followed by
    /// .awsglobalaccelerator.com. For example:
    /// a1234567890abcdef.awsglobalaccelerator.com.
    ///
    /// If you have a dual-stack accelerator, you also have a second DNS name,
    /// `DualStackDnsName`, that points to both
    /// the A record and the AAAA record for all four static addresses for the
    /// accelerator: two IPv4 addresses and two IPv6 addresses.
    ///
    /// For more information about the default DNS name, see [
    /// Support for DNS addressing in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/dns-addressing-custom-domains.dns-addressing.html) in the *Global Accelerator Developer Guide*.
    dns_name: ?[]const u8,

    /// The Domain Name System (DNS) name that Global Accelerator creates that
    /// points to a dual-stack accelerator's four static IP addresses:
    /// two IPv4 addresses and two IPv6 addresses.
    ///
    /// The naming convention for the dual-stack DNS name is the following: A
    /// lowercase letter a,
    /// followed by a 16-bit random hex string, followed by
    /// .dualstack.awsglobalaccelerator.com. For example:
    /// a1234567890abcdef.dualstack.awsglobalaccelerator.com.
    ///
    /// Note: Global Accelerator also assigns a default DNS name, `DnsName`, to your
    /// accelerator that points just to the static IPv4 addresses.
    ///
    /// For more information, see [
    /// Support for DNS addressing in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-accelerators.html#about-accelerators.dns-addressing) in the *Global Accelerator Developer Guide*.
    dual_stack_dns_name: ?[]const u8,

    /// Indicates whether the accelerator is enabled. The value is true or false.
    /// The default value is true.
    ///
    /// If the value is set to true, the accelerator cannot be deleted. If set to
    /// false, accelerator can be deleted.
    enabled: ?bool,

    /// A history of changes that you make to an accelerator in Global Accelerator.
    events: ?[]const AcceleratorEvent,

    /// The IP address type that an accelerator supports. For a standard
    /// accelerator, the value can be IPV4 or DUAL_STACK.
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
    status: ?AcceleratorStatus,

    pub const json_field_names = .{
        .accelerator_arn = "AcceleratorArn",
        .created_time = "CreatedTime",
        .dns_name = "DnsName",
        .dual_stack_dns_name = "DualStackDnsName",
        .enabled = "Enabled",
        .events = "Events",
        .ip_address_type = "IpAddressType",
        .ip_sets = "IpSets",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};
