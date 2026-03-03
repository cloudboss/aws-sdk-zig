const ScopeName = @import("scope_name.zig").ScopeName;

/// Describes the scope of a recommendation preference.
///
/// Recommendation preferences can be created at the organization level (for
/// management
/// accounts of an organization only), account level, and resource level. For
/// more
/// information, see [Activating
/// enhanced infrastructure
/// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
/// Guide*.
///
/// You cannot create recommendation preferences for Amazon EC2 Auto Scaling
/// groups at the
/// organization and account levels. You can create recommendation preferences
/// for
/// Amazon EC2 Auto Scaling groups only at the resource level by specifying a
/// scope name
/// of `ResourceArn` and a scope value of the Amazon EC2 Auto Scaling group
/// Amazon
/// Resource Name (ARN). This will configure the preference for all instances
/// that are
/// part of the specified Amazon EC2 Auto Scaling group. You also cannot create
/// recommendation
/// preferences at the resource level for instances that are part of an Amazon
/// EC2 Auto Scaling group. You can create recommendation preferences at the
/// resource level only for
/// standalone instances.
pub const Scope = struct {
    /// The name of the scope.
    ///
    /// The following scopes are possible:
    ///
    /// * `Organization` - Specifies that the recommendation preference
    /// applies at the organization level, for all member accounts of an
    /// organization.
    ///
    /// * `AccountId` - Specifies that the recommendation preference applies
    /// at the account level, for all resources of a given resource type in an
    /// account.
    ///
    /// * `ResourceArn` - Specifies that the recommendation preference
    /// applies at the individual resource level.
    name: ?ScopeName = null,

    /// The value of the scope.
    ///
    /// If you specified the `name` of the scope as:
    ///
    /// * `Organization` - The `value` must be
    /// `ALL_ACCOUNTS`.
    ///
    /// * `AccountId` - The `value` must be a 12-digit Amazon Web Services account
    ///   ID.
    ///
    /// * `ResourceArn` - The `value` must be the Amazon Resource
    /// Name (ARN) of an EC2 instance or an Amazon EC2 Auto Scaling group.
    ///
    /// Only EC2 instance and Amazon EC2 Auto Scaling group ARNs are currently
    /// supported.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
