const DomainScope = @import("domain_scope.zig").DomainScope;

/// DNS prevalidation options for domain validation.
pub const DnsPrevalidationOptions = struct {
    /// The scope of domains covered by this prevalidation.
    domain_scope: ?DomainScope = null,

    /// The Route 53 hosted zone ID for DNS validation.
    hosted_zone_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_scope = "DomainScope",
        .hosted_zone_id = "HostedZoneId",
    };
};
