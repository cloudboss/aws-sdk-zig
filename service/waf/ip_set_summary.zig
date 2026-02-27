/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains the identifier and the name of the `IPSet`.
pub const IPSetSummary = struct {
    /// The `IPSetId` for an IPSet. You can use `IPSetId` in a GetIPSet request to
    /// get detailed
    /// information about an IPSet.
    ip_set_id: []const u8,

    /// A friendly name or description of the IPSet. You can't change the name of an
    /// `IPSet` after you create it.
    name: []const u8,

    pub const json_field_names = .{
        .ip_set_id = "IPSetId",
        .name = "Name",
    };
};
