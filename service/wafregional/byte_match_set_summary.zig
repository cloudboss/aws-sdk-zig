/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Returned by ListByteMatchSets. Each `ByteMatchSetSummary` object includes
/// the `Name` and
/// `ByteMatchSetId` for one ByteMatchSet.
pub const ByteMatchSetSummary = struct {
    /// The `ByteMatchSetId` for a `ByteMatchSet`. You use `ByteMatchSetId` to get
    /// information about a `ByteMatchSet`,
    /// update a `ByteMatchSet`, remove a `ByteMatchSet` from a `Rule`, and delete a
    /// `ByteMatchSet` from AWS WAF.
    ///
    /// `ByteMatchSetId` is returned by CreateByteMatchSet and by ListByteMatchSets.
    byte_match_set_id: []const u8,

    /// A friendly name or description of the ByteMatchSet. You can't change `Name`
    /// after you create a `ByteMatchSet`.
    name: []const u8,

    pub const json_field_names = .{
        .byte_match_set_id = "ByteMatchSetId",
        .name = "Name",
    };
};
