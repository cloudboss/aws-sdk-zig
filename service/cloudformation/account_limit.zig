/// Describes the current CloudFormation limits for your account.
///
/// CloudFormation has the following limits per account:
///
/// * Number of concurrent resources
///
/// * Number of stacks
///
/// * Number of stack outputs
///
/// For more information, see [Understand CloudFormation
/// quotas](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html) in the *CloudFormation User Guide*.
pub const AccountLimit = struct {
    /// The name of the account limit.
    ///
    /// Values: `ConcurrentResourcesLimit` | `StackLimit` |
    /// `StackOutputsLimit`
    name: ?[]const u8,

    /// The value that's associated with the account limit name.
    value: ?i32,
};
