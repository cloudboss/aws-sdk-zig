/// Contains information about why certain features failed to be enabled or
/// configured for the hosted zone.
pub const HostedZoneFailureReasons = struct {
    /// The reason why accelerated recovery failed to be enabled or disabled for the
    /// hosted zone, if applicable.
    accelerated_recovery: ?[]const u8 = null,
};
