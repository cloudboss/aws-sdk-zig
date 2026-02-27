const GeoMatchConstraint = @import("geo_match_constraint.zig").GeoMatchConstraint;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains one or more countries that AWS WAF will search for.
pub const GeoMatchSet = struct {
    /// An array of GeoMatchConstraint objects, which contain the country that you
    /// want AWS WAF to search for.
    geo_match_constraints: []const GeoMatchConstraint,

    /// The `GeoMatchSetId` for an `GeoMatchSet`. You use `GeoMatchSetId` to get
    /// information about a
    /// `GeoMatchSet` (see GeoMatchSet), update a `GeoMatchSet` (see
    /// UpdateGeoMatchSet), insert a `GeoMatchSet` into a `Rule` or delete one from
    /// a `Rule` (see UpdateRule), and delete a `GeoMatchSet` from AWS WAF (see
    /// DeleteGeoMatchSet).
    ///
    /// `GeoMatchSetId` is returned by CreateGeoMatchSet and by ListGeoMatchSets.
    geo_match_set_id: []const u8,

    /// A friendly name or description of the GeoMatchSet. You can't change the name
    /// of an `GeoMatchSet` after you create it.
    name: ?[]const u8,

    pub const json_field_names = .{
        .geo_match_constraints = "GeoMatchConstraints",
        .geo_match_set_id = "GeoMatchSetId",
        .name = "Name",
    };
};
