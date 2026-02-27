const FieldToMatch = @import("field_to_match.zig").FieldToMatch;
const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The regular expression pattern that you want AWS WAF to search for in web
/// requests, the location in requests that you want AWS WAF to search, and
/// other settings. Each `RegexMatchTuple` object contains:
///
/// * The part of a web request that you want AWS WAF to inspect, such as a
///   query string or the value of the `User-Agent` header.
///
/// * The identifier of the pattern (a regular expression) that you want AWS WAF
///   to look for. For more information, see RegexPatternSet.
///
/// * Whether to perform any conversions on the request, such as converting it
///   to lowercase, before inspecting it for the specified string.
pub const RegexMatchTuple = struct {
    /// Specifies where in a web request to look for the `RegexPatternSet`.
    field_to_match: FieldToMatch,

    /// The `RegexPatternSetId` for a `RegexPatternSet`. You use `RegexPatternSetId`
    /// to get information about a
    /// `RegexPatternSet` (see GetRegexPatternSet), update a `RegexPatternSet` (see
    /// UpdateRegexPatternSet),
    /// insert a `RegexPatternSet` into a `RegexMatchSet` or delete one from a
    /// `RegexMatchSet` (see UpdateRegexMatchSet), and
    /// delete an `RegexPatternSet` from AWS WAF (see DeleteRegexPatternSet).
    ///
    /// `RegexPatternSetId` is returned by CreateRegexPatternSet and by
    /// ListRegexPatternSets.
    regex_pattern_set_id: []const u8,

    /// Text transformations eliminate some of the unusual formatting that attackers
    /// use in web requests in an effort to bypass AWS WAF.
    /// If you specify a transformation, AWS WAF performs the transformation on
    /// `RegexPatternSet` before inspecting a request for a match.
    ///
    /// You can only specify a single type of TextTransformation.
    ///
    /// **CMD_LINE**
    ///
    /// When you're concerned that attackers are injecting an operating system
    /// commandline command and using unusual formatting to disguise some or all of
    /// the command, use this option to perform the following transformations:
    ///
    /// * Delete the following characters: \ " ' ^
    ///
    /// * Delete spaces before the following characters: / (
    ///
    /// * Replace the following characters with a space: , ;
    ///
    /// * Replace multiple spaces with one space
    ///
    /// * Convert uppercase letters (A-Z) to lowercase (a-z)
    ///
    /// **COMPRESS_WHITE_SPACE**
    ///
    /// Use this option to replace the following characters with a space character
    /// (decimal 32):
    ///
    /// * \f, formfeed, decimal 12
    ///
    /// * \t, tab, decimal 9
    ///
    /// * \n, newline, decimal 10
    ///
    /// * \r, carriage return, decimal 13
    ///
    /// * \v, vertical tab, decimal 11
    ///
    /// * non-breaking space, decimal 160
    ///
    /// `COMPRESS_WHITE_SPACE` also replaces multiple spaces with one space.
    ///
    /// **HTML_ENTITY_DECODE**
    ///
    /// Use this option to replace HTML-encoded characters with unencoded
    /// characters. `HTML_ENTITY_DECODE` performs
    /// the following operations:
    ///
    /// * Replaces `(ampersand)quot;` with `"`
    ///
    /// * Replaces `(ampersand)nbsp;` with a non-breaking space, decimal 160
    ///
    /// * Replaces `(ampersand)lt;` with a "less than" symbol
    ///
    /// * Replaces `(ampersand)gt;` with `>`
    ///
    /// * Replaces characters that are represented in hexadecimal format,
    ///   `(ampersand)#xhhhh;`, with the corresponding
    /// characters
    ///
    /// * Replaces characters that are represented in decimal format,
    ///   `(ampersand)#nnnn;`, with the corresponding
    /// characters
    ///
    /// **LOWERCASE**
    ///
    /// Use this option to convert uppercase letters (A-Z) to lowercase (a-z).
    ///
    /// **URL_DECODE**
    ///
    /// Use this option to decode a URL-encoded value.
    ///
    /// **NONE**
    ///
    /// Specify `NONE` if you don't want to perform any text transformations.
    text_transformation: TextTransformation,

    pub const json_field_names = .{
        .field_to_match = "FieldToMatch",
        .regex_pattern_set_id = "RegexPatternSetId",
        .text_transformation = "TextTransformation",
    };
};
