const GeoRestriction = @import("geo_restriction.zig").GeoRestriction;

/// A complex type that identifies ways in which you want to restrict
/// distribution of your content.
pub const Restrictions = struct {
    /// A complex type that controls the countries in which your content is
    /// distributed. CloudFront determines the location of your users using
    /// `MaxMind` GeoIP databases.
    geo_restriction: GeoRestriction,
};
