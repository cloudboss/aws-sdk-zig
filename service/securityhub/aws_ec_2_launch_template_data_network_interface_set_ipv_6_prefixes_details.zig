/// Provides details on one or more IPv6 prefixes to be assigned to the network
/// interface.
pub const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6PrefixesDetails = struct {
    /// The IPv6 prefix.
    ipv_6_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .ipv_6_prefix = "Ipv6Prefix",
    };
};
