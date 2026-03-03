const SOA = @import("soa.zig").SOA;

/// A complex type that contains the ID for the Route 53 hosted zone that Cloud
/// Map creates when
/// you create a namespace.
pub const DnsProperties = struct {
    /// The ID for the Route 53 hosted zone that Cloud Map creates when you create a
    /// namespace.
    hosted_zone_id: ?[]const u8 = null,

    /// Start of Authority (SOA) record for the hosted zone.
    soa: ?SOA = null,

    pub const json_field_names = .{
        .hosted_zone_id = "HostedZoneId",
        .soa = "SOA",
    };
};
