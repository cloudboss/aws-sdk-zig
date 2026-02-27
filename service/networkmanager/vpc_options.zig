/// Describes the VPC options.
pub const VpcOptions = struct {
    /// Indicates whether appliance mode is supported. If enabled, traffic flow
    /// between a source and destination use the same Availability Zone for the VPC
    /// attachment for the lifetime of that flow. The default value is `false`.
    appliance_mode_support: bool = false,

    /// Indicates whether DNS is supported.
    dns_support: bool = false,

    /// Indicates whether IPv6 is supported.
    ipv_6_support: bool = false,

    /// Indicates whether security group referencing is enabled for this VPC
    /// attachment. The default is `true`. However, at the core network policy-level
    /// the default is set to `false`.
    security_group_referencing_support: bool = false,

    pub const json_field_names = .{
        .appliance_mode_support = "ApplianceModeSupport",
        .dns_support = "DnsSupport",
        .ipv_6_support = "Ipv6Support",
        .security_group_referencing_support = "SecurityGroupReferencingSupport",
    };
};
