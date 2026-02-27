const RegexMatchTuple = @import("regex_match_tuple.zig").RegexMatchTuple;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// In a GetRegexMatchSet request, `RegexMatchSet` is a complex type that
/// contains the `RegexMatchSetId` and
/// `Name` of a `RegexMatchSet`, and the values that you specified when you
/// updated the `RegexMatchSet`.
///
/// The values are contained in a `RegexMatchTuple` object, which specify the
/// parts of web requests that you want AWS WAF to inspect and the values that
/// you want AWS WAF to search for. If a `RegexMatchSet` contains more than one
/// `RegexMatchTuple` object, a request needs to match the settings in only one
/// `ByteMatchTuple`
/// to be considered a match.
pub const RegexMatchSet = struct {
    /// A friendly name or description of the RegexMatchSet. You can't change `Name`
    /// after you create a
    /// `RegexMatchSet`.
    name: ?[]const u8,

    /// The `RegexMatchSetId` for a `RegexMatchSet`. You use `RegexMatchSetId` to
    /// get information about a
    /// `RegexMatchSet` (see GetRegexMatchSet), update a `RegexMatchSet` (see
    /// UpdateRegexMatchSet),
    /// insert a `RegexMatchSet` into a `Rule` or delete one from a `Rule` (see
    /// UpdateRule), and
    /// delete a `RegexMatchSet` from AWS WAF (see DeleteRegexMatchSet).
    ///
    /// `RegexMatchSetId` is returned by CreateRegexMatchSet and by
    /// ListRegexMatchSets.
    regex_match_set_id: ?[]const u8,

    /// Contains an array of RegexMatchTuple objects. Each `RegexMatchTuple`
    /// object contains:
    ///
    /// * The part of a web request that you want AWS WAF to inspect, such as a
    ///   query string or the value of the `User-Agent` header.
    ///
    /// * The identifier of the pattern (a regular expression) that you want AWS WAF
    ///   to look for. For more information, see RegexPatternSet.
    ///
    /// * Whether to perform any conversions on the request, such as converting it
    ///   to lowercase, before inspecting it for the specified string.
    regex_match_tuples: ?[]const RegexMatchTuple,

    pub const json_field_names = .{
        .name = "Name",
        .regex_match_set_id = "RegexMatchSetId",
        .regex_match_tuples = "RegexMatchTuples",
    };
};
