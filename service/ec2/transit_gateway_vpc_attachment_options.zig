const ApplianceModeSupportValue = @import("appliance_mode_support_value.zig").ApplianceModeSupportValue;
const DnsSupportValue = @import("dns_support_value.zig").DnsSupportValue;
const Ipv6SupportValue = @import("ipv_6_support_value.zig").Ipv6SupportValue;
const SecurityGroupReferencingSupportValue = @import("security_group_referencing_support_value.zig").SecurityGroupReferencingSupportValue;

/// Describes the VPC attachment options.
pub const TransitGatewayVpcAttachmentOptions = struct {
    /// Indicates whether appliance mode support is enabled.
    appliance_mode_support: ?ApplianceModeSupportValue,

    /// Indicates whether DNS support is enabled.
    dns_support: ?DnsSupportValue,

    /// Indicates whether IPv6 support is disabled.
    ipv_6_support: ?Ipv6SupportValue,

    /// Enables you to reference a security group across VPCs attached to a transit
    /// gateway to simplify security group management.
    ///
    /// This option is enabled by default.
    ///
    /// For more information about security group referencing, see [Security group
    /// referencing](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html#vpc-attachment-security) in the *Amazon Web Services Transit Gateways Guide*.
    security_group_referencing_support: ?SecurityGroupReferencingSupportValue,
};
