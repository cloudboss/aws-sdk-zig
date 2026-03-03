const GeoRestrictionType = @import("geo_restriction_type.zig").GeoRestrictionType;

/// The customizations that you specified for the distribution tenant for
/// geographic restrictions.
pub const GeoRestrictionCustomization = struct {
    /// The locations for geographic restrictions.
    locations: ?[]const []const u8 = null,

    /// The method that you want to use to restrict distribution of your content by
    /// country:
    ///
    /// * `none`: No geographic restriction is enabled, meaning access to content is
    ///   not restricted by client geo location.
    /// * `blacklist`: The `Location` elements specify the countries in which you
    ///   don't want CloudFront to distribute your content.
    /// * `whitelist`: The `Location` elements specify the countries in which you
    ///   want CloudFront to distribute your content.
    restriction_type: GeoRestrictionType,
};
