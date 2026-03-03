/// Information about Amazon Web Services CloudFormation stacks. You can use up
/// to 500
/// stacks to specify which Amazon Web Services resources in your account to
/// analyze. For more
/// information, see
/// [Stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacks.html) in the
/// *Amazon Web Services CloudFormation User Guide*.
pub const CloudFormationCollectionFilter = struct {
    /// An array of CloudFormation stack names.
    stack_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .stack_names = "StackNames",
    };
};
