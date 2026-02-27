const TargetResource = @import("target_resource.zig").TargetResource;

/// A component for DNS/routing control readiness checks and architecture
/// checks.
pub const DNSTargetResource = struct {
    /// The domain name that acts as an ingress point to a portion of the customer
    /// application.
    domain_name: ?[]const u8,

    /// The hosted zone Amazon Resource Name (ARN) that contains the DNS record with
    /// the provided name of the target resource.
    hosted_zone_arn: ?[]const u8,

    /// The Route 53 record set ID that uniquely identifies a DNS record, given a
    /// name and a type.
    record_set_id: ?[]const u8,

    /// The type of DNS record of the target resource.
    record_type: ?[]const u8,

    /// The target resource of the DNS target resource.
    target_resource: ?TargetResource,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .hosted_zone_arn = "HostedZoneArn",
        .record_set_id = "RecordSetId",
        .record_type = "RecordType",
        .target_resource = "TargetResource",
    };
};
