const HostnameType = @import("hostname_type.zig").HostnameType;

/// Describes the options for instance hostnames.
pub const LaunchTemplatePrivateDnsNameOptionsRequest = struct {
    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// AAAA
    /// records.
    enable_resource_name_dns_aaaa_record: ?bool,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// A
    /// records.
    enable_resource_name_dns_a_record: ?bool,

    /// The type of hostname for Amazon EC2 instances. For IPv4 only subnets, an
    /// instance DNS name
    /// must be based on the instance IPv4 address. For IPv6 native subnets, an
    /// instance DNS
    /// name must be based on the instance ID. For dual-stack subnets, you can
    /// specify whether
    /// DNS names use the instance IPv4 address or the instance ID.
    hostname_type: ?HostnameType,
};
