const HostedZoneLimitType = @import("hosted_zone_limit_type.zig").HostedZoneLimitType;

/// A complex type that contains the type of limit that you specified in the
/// request and
/// the current value for that limit.
pub const HostedZoneLimit = struct {
    /// The limit that you requested. Valid values include the following:
    ///
    /// * **MAX_RRSETS_BY_ZONE**: The maximum number of
    /// records that you can create in the specified hosted zone.
    ///
    /// * **MAX_VPCS_ASSOCIATED_BY_ZONE**: The maximum
    /// number of Amazon VPCs that you can associate with the specified private
    /// hosted
    /// zone.
    type: HostedZoneLimitType,

    /// The current value for the limit that is specified by `Type`.
    value: i64,
};
