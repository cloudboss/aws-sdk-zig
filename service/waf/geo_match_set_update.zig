const ChangeAction = @import("change_action.zig").ChangeAction;
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
/// Specifies the type of update to perform to an GeoMatchSet with
/// UpdateGeoMatchSet.
pub const GeoMatchSetUpdate = struct {
    /// Specifies whether to insert or delete a country with UpdateGeoMatchSet.
    action: ChangeAction,

    /// The country from which web requests originate that you want AWS WAF to
    /// search for.
    geo_match_constraint: GeoMatchConstraint,

    pub const json_field_names = .{
        .action = "Action",
        .geo_match_constraint = "GeoMatchConstraint",
    };
};
