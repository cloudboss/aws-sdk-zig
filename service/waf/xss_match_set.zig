const XssMatchTuple = @import("xss_match_tuple.zig").XssMatchTuple;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// A complex type that contains `XssMatchTuple` objects, which specify the
/// parts of web requests that you
/// want AWS WAF to inspect for cross-site scripting attacks and, if you want
/// AWS WAF to inspect a header, the name of the header. If a
/// `XssMatchSet` contains more than one `XssMatchTuple` object, a request needs
/// to
/// include cross-site scripting attacks in only one of the specified parts of
/// the request to be considered a match.
pub const XssMatchSet = struct {
    /// The name, if any, of the `XssMatchSet`.
    name: ?[]const u8,

    /// A unique identifier for an `XssMatchSet`. You use `XssMatchSetId` to get
    /// information about an
    /// `XssMatchSet` (see GetXssMatchSet), update an `XssMatchSet`
    /// (see UpdateXssMatchSet), insert an `XssMatchSet` into a `Rule` or
    /// delete one from a `Rule` (see UpdateRule), and delete an `XssMatchSet` from
    /// AWS WAF
    /// (see DeleteXssMatchSet).
    ///
    /// `XssMatchSetId` is returned by CreateXssMatchSet and by ListXssMatchSets.
    xss_match_set_id: []const u8,

    /// Specifies the parts of web requests that you want to inspect for cross-site
    /// scripting attacks.
    xss_match_tuples: []const XssMatchTuple,

    pub const json_field_names = .{
        .name = "Name",
        .xss_match_set_id = "XssMatchSetId",
        .xss_match_tuples = "XssMatchTuples",
    };
};
