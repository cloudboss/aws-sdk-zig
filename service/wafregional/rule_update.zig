const ChangeAction = @import("change_action.zig").ChangeAction;
const Predicate = @import("predicate.zig").Predicate;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Specifies a `Predicate` (such as an `IPSet`) and indicates whether you want
/// to add it to a
/// `Rule` or delete it from a `Rule`.
pub const RuleUpdate = struct {
    /// Specify `INSERT` to add a `Predicate` to a `Rule`. Use `DELETE` to remove a
    /// `Predicate` from a `Rule`.
    action: ChangeAction,

    /// The ID of the `Predicate` (such as an `IPSet`) that you want to add to a
    /// `Rule`.
    predicate: Predicate,

    pub const json_field_names = .{
        .action = "Action",
        .predicate = "Predicate",
    };
};
