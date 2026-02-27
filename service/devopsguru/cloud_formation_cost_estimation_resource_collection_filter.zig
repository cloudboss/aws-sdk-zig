/// Information about an Amazon Web Services CloudFormation stack used to create
/// a monthly cost estimate
/// for DevOps Guru to analyze Amazon Web Services resources. The maximum number
/// of stacks you can specify for a
/// cost estimate is one. The estimate created is for the cost to analyze the
/// Amazon Web Services
/// resources defined by the stack. For more information, see
/// [Stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacks.html) in the
/// *Amazon Web Services CloudFormation User Guide*.
pub const CloudFormationCostEstimationResourceCollectionFilter = struct {
    /// An array of CloudFormation stack names. Its size is fixed at 1 item.
    stack_names: ?[]const []const u8,

    pub const json_field_names = .{
        .stack_names = "StackNames",
    };
};
