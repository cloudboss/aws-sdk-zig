const ChangeAction = @import("change_action.zig").ChangeAction;
const ByteMatchTuple = @import("byte_match_tuple.zig").ByteMatchTuple;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// In an UpdateByteMatchSet request, `ByteMatchSetUpdate` specifies whether to
/// insert or delete a
/// ByteMatchTuple and includes the settings for the `ByteMatchTuple`.
pub const ByteMatchSetUpdate = struct {
    /// Specifies whether to insert or delete a ByteMatchTuple.
    action: ChangeAction,

    /// Information about the part of a web request that you want AWS WAF to inspect
    /// and the value that you want AWS WAF to search for.
    /// If you specify `DELETE` for the value of `Action`, the `ByteMatchTuple`
    /// values must
    /// exactly match the values in the `ByteMatchTuple` that you want to delete
    /// from the `ByteMatchSet`.
    byte_match_tuple: ByteMatchTuple,

    pub const json_field_names = .{
        .action = "Action",
        .byte_match_tuple = "ByteMatchTuple",
    };
};
