const ChangeAction = @import("change_action.zig").ChangeAction;
const IPSetDescriptor = @import("ip_set_descriptor.zig").IPSetDescriptor;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Specifies the type of update to perform to an IPSet with UpdateIPSet.
pub const IPSetUpdate = struct {
    /// Specifies whether to insert or delete an IP address with UpdateIPSet.
    action: ChangeAction,

    /// The IP address type (`IPV4` or `IPV6`) and the IP address range (in CIDR
    /// notation) that web requests originate from.
    ip_set_descriptor: IPSetDescriptor,

    pub const json_field_names = .{
        .action = "Action",
        .ip_set_descriptor = "IPSetDescriptor",
    };
};
