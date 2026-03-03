const HostnameType = @import("hostname_type.zig").HostnameType;

/// Describes the options for instance hostnames.
pub const LaunchTemplatePrivateDnsNameOptions = struct {
    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// AAAA
    /// records.
    enable_resource_name_dns_aaaa_record: ?bool = null,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// A
    /// records.
    enable_resource_name_dns_a_record: ?bool = null,

    /// The type of hostname to assign to an instance.
    hostname_type: ?HostnameType = null,
};
