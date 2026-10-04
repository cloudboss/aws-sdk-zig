const DomainScope = @import("domain_scope.zig").DomainScope;
const ResourceRecord = @import("resource_record.zig").ResourceRecord;

/// DNS prevalidation details including the resource record for validation.
pub const DnsPrevalidationDetails = struct {
    /// The scope of domains covered by this prevalidation.
    domain_scope: ?DomainScope = null,

    /// The Route 53 hosted zone ID for DNS validation.
    hosted_zone_id: ?[]const u8 = null,

    /// The DNS resource record to create for domain validation.
    resource_record: ?ResourceRecord = null,

    pub const json_field_names = .{
        .domain_scope = "DomainScope",
        .hosted_zone_id = "HostedZoneId",
        .resource_record = "ResourceRecord",
    };
};
