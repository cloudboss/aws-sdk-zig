/// Describes a DNS entry.
pub const DnsEntry = struct {
    /// The DNS name.
    dns_name: ?[]const u8 = null,

    /// The ID of the private hosted zone.
    hosted_zone_id: ?[]const u8 = null,
};
