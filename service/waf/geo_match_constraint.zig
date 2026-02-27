const GeoMatchConstraintType = @import("geo_match_constraint_type.zig").GeoMatchConstraintType;
const GeoMatchConstraintValue = @import("geo_match_constraint_value.zig").GeoMatchConstraintValue;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The country from which web requests originate that you want AWS WAF to
/// search for.
pub const GeoMatchConstraint = struct {
    /// The type of geographical area you want AWS WAF to search for. Currently
    /// `Country` is the only valid value.
    type: GeoMatchConstraintType,

    /// The country that you want AWS WAF to search for.
    value: GeoMatchConstraintValue,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
