const IpamDiscoveryFailureReason = @import("ipam_discovery_failure_reason.zig").IpamDiscoveryFailureReason;

/// An IPAM discovered account. A discovered account is an Amazon Web Services
/// account that is monitored under a resource discovery. If you have integrated
/// IPAM with Amazon Web Services Organizations, all accounts in the
/// organization are discovered accounts.
pub const IpamDiscoveredAccount = struct {
    /// The account ID.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services Region that the account information is returned
    /// from.
    /// An account can be discovered in multiple regions and will have a separate
    /// discovered account for each Region.
    discovery_region: ?[]const u8 = null,

    /// The resource discovery failure reason.
    failure_reason: ?IpamDiscoveryFailureReason = null,

    /// The last attempted resource discovery time.
    last_attempted_discovery_time: ?i64 = null,

    /// The last successful resource discovery time.
    last_successful_discovery_time: ?i64 = null,

    /// The ID of an Organizational Unit in Amazon Web Services Organizations.
    organizational_unit_id: ?[]const u8 = null,
};
