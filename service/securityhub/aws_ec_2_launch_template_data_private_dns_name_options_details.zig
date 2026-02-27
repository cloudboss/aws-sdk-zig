/// Describes the options for Amazon EC2 instance hostnames.
pub const AwsEc2LaunchTemplateDataPrivateDnsNameOptionsDetails = struct {
    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// AAAA records.
    enable_resource_name_dns_aaaa_record: ?bool,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// A records.
    enable_resource_name_dns_a_record: ?bool,

    /// The type of hostname for EC2 instances.
    hostname_type: ?[]const u8,

    pub const json_field_names = .{
        .enable_resource_name_dns_aaaa_record = "EnableResourceNameDnsAAAARecord",
        .enable_resource_name_dns_a_record = "EnableResourceNameDnsARecord",
        .hostname_type = "HostnameType",
    };
};
