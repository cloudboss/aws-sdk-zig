const DirectoryVpcSettings = @import("directory_vpc_settings.zig").DirectoryVpcSettings;

/// Contains configuration parameters required to perform a directory
/// assessment.
pub const AssessmentConfiguration = struct {
    /// A list of IP addresses for the DNS servers or domain controllers in your
    /// self-managed
    /// AD that are tested during the assessment.
    customer_dns_ips: []const []const u8,

    /// The fully qualified domain name (FQDN) of the self-managed AD domain to
    /// assess.
    dns_name: []const u8,

    /// The identifiers of the self-managed instances with SSM that are used to
    /// perform
    /// connectivity and validation tests.
    instance_ids: []const []const u8,

    /// By default, the service attaches a security group to allow network access to
    /// the
    /// self-managed nodes in your Amazon VPC. You can optionally supply your own
    /// security group that
    /// allows network traffic to and from your self-managed domain controllers
    /// outside of your
    /// Amazon VPC.
    security_group_ids: ?[]const []const u8 = null,

    vpc_settings: DirectoryVpcSettings,

    pub const json_field_names = .{
        .customer_dns_ips = "CustomerDnsIps",
        .dns_name = "DnsName",
        .instance_ids = "InstanceIds",
        .security_group_ids = "SecurityGroupIds",
        .vpc_settings = "VpcSettings",
    };
};
