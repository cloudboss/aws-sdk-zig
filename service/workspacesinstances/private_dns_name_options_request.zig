const HostnameTypeEnum = @import("hostname_type_enum.zig").HostnameTypeEnum;

/// Configures private DNS name settings for WorkSpace Instance.
pub const PrivateDnsNameOptionsRequest = struct {
    /// Enables DNS AAAA record for resource name resolution.
    enable_resource_name_dns_aaaa_record: ?bool,

    /// Enables DNS A record for resource name resolution.
    enable_resource_name_dns_a_record: ?bool,

    /// Specifies the type of hostname configuration.
    hostname_type: ?HostnameTypeEnum,

    pub const json_field_names = .{
        .enable_resource_name_dns_aaaa_record = "EnableResourceNameDnsAAAARecord",
        .enable_resource_name_dns_a_record = "EnableResourceNameDnsARecord",
        .hostname_type = "HostnameType",
    };
};
