const DnsEntry = @import("dns_entry.zig").DnsEntry;
const ServiceStatus = @import("service_status.zig").ServiceStatus;

/// Summary information about a service.
pub const ServiceSummary = struct {
    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8 = null,

    /// The date and time that the service was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The custom domain name of the service.
    custom_domain_name: ?[]const u8 = null,

    /// The DNS information.
    dns_entry: ?DnsEntry = null,

    /// The ID of the service.
    id: ?[]const u8 = null,

    /// The date and time that the service was last updated, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    /// The status.
    status: ?ServiceStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .dns_entry = "dnsEntry",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};
