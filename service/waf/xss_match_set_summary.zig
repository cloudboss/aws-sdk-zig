/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The `Id` and `Name` of an `XssMatchSet`.
pub const XssMatchSetSummary = struct {
    /// The name of the `XssMatchSet`, if any, specified by `Id`.
    name: []const u8,

    /// A unique identifier for an `XssMatchSet`. You use `XssMatchSetId` to get
    /// information about a
    /// `XssMatchSet` (see GetXssMatchSet), update an `XssMatchSet`
    /// (see UpdateXssMatchSet), insert an `XssMatchSet` into a `Rule` or
    /// delete one from a `Rule` (see UpdateRule), and delete an `XssMatchSet` from
    /// AWS WAF
    /// (see DeleteXssMatchSet).
    ///
    /// `XssMatchSetId` is returned by CreateXssMatchSet and by ListXssMatchSets.
    xss_match_set_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .xss_match_set_id = "XssMatchSetId",
    };
};
