/// A complex type that contains an optional comment about your hosted zone. If
/// you don't
/// want to specify a comment, omit both the `HostedZoneConfig` and
/// `Comment` elements.
pub const HostedZoneConfig = struct {
    /// Any comments that you want to include about the hosted zone.
    comment: ?[]const u8 = null,

    /// A value that indicates whether this is a private hosted zone.
    private_zone: bool = false,
};
