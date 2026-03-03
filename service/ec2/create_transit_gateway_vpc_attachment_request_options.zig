const ApplianceModeSupportValue = @import("appliance_mode_support_value.zig").ApplianceModeSupportValue;
const DnsSupportValue = @import("dns_support_value.zig").DnsSupportValue;
const Ipv6SupportValue = @import("ipv_6_support_value.zig").Ipv6SupportValue;
const SecurityGroupReferencingSupportValue = @import("security_group_referencing_support_value.zig").SecurityGroupReferencingSupportValue;

/// Describes the options for a VPC attachment.
pub const CreateTransitGatewayVpcAttachmentRequestOptions = struct {
    /// Enable or disable support for appliance mode. If enabled, a traffic flow
    /// between a source and destination uses the same Availability Zone for the VPC
    /// attachment for the lifetime of that flow. The default is `disable`.
    appliance_mode_support: ?ApplianceModeSupportValue = null,

    /// Enable or disable DNS support. The default is `enable`.
    dns_support: ?DnsSupportValue = null,

    /// Enable or disable IPv6 support. The default is `disable`.
    ipv_6_support: ?Ipv6SupportValue = null,

    /// Enables you to reference a security group across VPCs attached to a transit
    /// gateway to simplify security group management.
    ///
    /// This option is set to `enable` by default. However, at the transit gateway
    /// level the default is set to `disable`.
    ///
    /// For more information about security group referencing, see [Security group
    /// referencing
    /// ](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html#vpc-attachment-security) in the *Amazon Web Services Transit Gateways Guide*.
    security_group_referencing_support: ?SecurityGroupReferencingSupportValue = null,
};
