/// Provides details on one or more IPv4 prefixes for a network interface.
pub const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv4PrefixesDetails = struct {
    /// The IPv4 prefix. For more information, see [Assigning prefixes to Amazon EC2
    /// network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-prefix-eni.html) in the *Amazon Elastic Compute Cloud User Guide*.
    ipv_4_prefix: ?[]const u8,

    pub const json_field_names = .{
        .ipv_4_prefix = "Ipv4Prefix",
    };
};
