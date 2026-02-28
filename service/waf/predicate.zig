const PredicateType = @import("predicate_type.zig").PredicateType;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Specifies the ByteMatchSet, IPSet, SqlInjectionMatchSet, XssMatchSet,
/// RegexMatchSet, GeoMatchSet, and SizeConstraintSet objects
/// that you want to add to a `Rule` and, for each object, indicates whether you
/// want to negate the settings, for example, requests that do
/// NOT originate from the IP address 192.0.2.44.
pub const Predicate = struct {
    /// A unique identifier for a predicate in a `Rule`, such as `ByteMatchSetId` or
    /// `IPSetId`.
    /// The ID is returned by the corresponding `Create` or `List` command.
    data_id: []const u8,

    /// Set `Negated` to `False` if you want AWS WAF to allow, block, or count
    /// requests based on the settings in the
    /// specified ByteMatchSet, IPSet, SqlInjectionMatchSet, XssMatchSet,
    /// RegexMatchSet, GeoMatchSet, or SizeConstraintSet.
    /// For example, if an `IPSet` includes the IP address `192.0.2.44`, AWS WAF
    /// will allow or block requests based on that IP address.
    ///
    /// Set `Negated` to `True` if you want AWS WAF to allow or block a request
    /// based on the negation
    /// of the settings in the ByteMatchSet, IPSet, SqlInjectionMatchSet,
    /// XssMatchSet, RegexMatchSet, GeoMatchSet, or SizeConstraintSet.
    /// For example, if an `IPSet` includes the IP address `192.0.2.44`, AWS WAF
    /// will allow, block, or count requests based on
    /// all IP addresses *except*
    /// `192.0.2.44`.
    negated: bool,

    /// The type of predicate in a `Rule`, such as `ByteMatch` or `IPSet`.
    @"type": PredicateType,

    pub const json_field_names = .{
        .data_id = "DataId",
        .negated = "Negated",
        .@"type" = "Type",
    };
};
