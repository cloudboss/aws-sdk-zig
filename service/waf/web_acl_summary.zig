/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains the identifier and the name or description of the WebACL.
pub const WebACLSummary = struct {
    /// A friendly name or description of the WebACL. You can't change the name of a
    /// `WebACL` after you create it.
    name: []const u8,

    /// A unique identifier for a `WebACL`. You use `WebACLId` to get information
    /// about a `WebACL`
    /// (see GetWebACL), update a `WebACL` (see UpdateWebACL), and delete a `WebACL`
    /// from AWS WAF
    /// (see DeleteWebACL).
    ///
    /// `WebACLId` is returned by CreateWebACL and by ListWebACLs.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .web_acl_id = "WebACLId",
    };
};
