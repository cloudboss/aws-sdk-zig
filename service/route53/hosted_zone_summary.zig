const HostedZoneOwner = @import("hosted_zone_owner.zig").HostedZoneOwner;

/// In the response to a `ListHostedZonesByVPC` request, the
/// `HostedZoneSummaries` element contains one `HostedZoneSummary`
/// element for each hosted zone that the specified Amazon VPC is associated
/// with. Each
/// `HostedZoneSummary` element contains the hosted zone name and ID, and
/// information about who owns the hosted zone.
pub const HostedZoneSummary = struct {
    /// The Route 53 hosted zone ID of a private hosted zone that the specified VPC
    /// is
    /// associated with.
    hosted_zone_id: []const u8,

    /// The name of the private hosted zone, such as `example.com`.
    name: []const u8,

    /// The owner of a private hosted zone that the specified VPC is associated
    /// with. The
    /// owner can be either an Amazon Web Services account or an Amazon Web Services
    /// service.
    owner: HostedZoneOwner,
};
